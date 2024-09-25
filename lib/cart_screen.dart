import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/cart_model.dart';
import 'package:shoppingcart/cart_provider.dart';
import 'package:shoppingcart/db_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper db = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text('My Product'),
        backgroundColor: const Color(0xff94B9FF),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder<List<Cart>>(
            future: cart.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                snapshot.data?.clear();
                return const Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No products in the cart',
                            style: TextStyle(fontSize: 24),
                          ),
                          SizedBox(height: 20),
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 130,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    snapshot.data![index].image.toString(),
                                    height: 100,
                                    width: 100,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                            color: Colors.white70),
                                        child: Center(
                                          child: Text(
                                            "${snapshot.data![index].productName.toString()}'s image",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data![index].productName
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                db.delete(snapshot.data![index]
                                                    .id!); // Make sure `delete` is defined in DBHelper
                                                cart.removeCounter();
                                                cart.removeTotalPrice(
                                                    double.parse(snapshot
                                                        .data![index]
                                                        .productPrice
                                                        .toString()));
                                                setState(
                                                    () {}); // Refresh the UI after deletion
                                              },
                                              child: const Icon(
                                                Icons.delete_rounded,
                                                color: Colors.red,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '${snapshot.data![index].quantity.toString()} ${snapshot.data![index].unitTag.toString()}: \$${snapshot.data![index].productPrice.toString()}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  int quantity = snapshot
                                                      .data![index].quantity!;
                                                  int price = snapshot
                                                      .data![index]
                                                      .initialPrice!;
                                                  quantity--;
                                                  int newPrice =
                                                      quantity * price;
                                                  if (quantity > 0) {
                                                    db
                                                        .updateQuantity(Cart(
                                                            id: snapshot
                                                                .data![index]
                                                                .id,
                                                            productId: snapshot
                                                                .data![index].id
                                                                .toString(),
                                                            productName:
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .productName
                                                                    .toString(),
                                                            initialPrice: snapshot
                                                                .data![index]
                                                                .initialPrice,
                                                            productPrice:
                                                                newPrice,
                                                            quantity: quantity,
                                                            unitTag: snapshot
                                                                .data![index]
                                                                .unitTag
                                                                .toString(),
                                                            image: snapshot
                                                                .data![index]
                                                                .image
                                                                .toString()))
                                                        .then((value) {
                                                      newPrice = 0;
                                                      quantity = 0;
                                                      cart.removeTotalPrice(
                                                          double.parse(snapshot
                                                              .data![index]
                                                              .initialPrice
                                                              .toString()));
                                                    }).onError((error,
                                                            stackTrace) {
                                                      print(error);
                                                    });
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Container(
                                                height: 35,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    snapshot
                                                        .data![index].quantity
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff94B9FF)),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              InkWell(
                                                onTap: () {
                                                  int quantity = snapshot
                                                      .data![index].quantity!;
                                                  int price = snapshot
                                                      .data![index]
                                                      .initialPrice!;
                                                  quantity++;
                                                  int newPrice =
                                                      quantity * price;
                                                  db
                                                      .updateQuantity(Cart(
                                                          id: snapshot
                                                              .data![index].id,
                                                          productId: snapshot
                                                              .data![index].id
                                                              .toString(),
                                                          productName: snapshot
                                                              .data![index]
                                                              .productName
                                                              .toString(),
                                                          initialPrice: snapshot
                                                              .data![index]
                                                              .initialPrice,
                                                          productPrice:
                                                              newPrice,
                                                          quantity: quantity,
                                                          unitTag: snapshot
                                                              .data![index]
                                                              .unitTag
                                                              .toString(),
                                                          image: snapshot
                                                              .data![index]
                                                              .image
                                                              .toString()))
                                                      .then((value) {
                                                    newPrice = 0;
                                                    quantity = 0;
                                                    cart.addTotalPrice(
                                                        double.parse(snapshot
                                                            .data![index]
                                                            .initialPrice
                                                            .toString()));
                                                  }).onError(
                                                          (error, stackTrace) {
                                                    print(error);
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const Text('Error');
            },
          ),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) == '0.00'
                  ? false
                  : true,
              child: Column(
                children: [
                  ReusableWidget(
                      title: 'Sub Total: ',
                      value: r'$' + value.getTotalPrice().toStringAsFixed(2))
                ],
              ),
            );
          }),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ],
        ),
      ),
    );
  }
}
