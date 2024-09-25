import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingcart/cart_provider.dart';
import 'package:shoppingcart/productlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await clearPreferences(); // Clear preferences before running the app
  runApp(const MyApp());
}

Future<void> clearPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductListScreen(),
        );
      }),
    );
  }
}
