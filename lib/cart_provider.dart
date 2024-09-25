import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingcart/cart_model.dart';
import 'package:shoppingcart/db_helper.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  int _counter = 0;
  int get counter => _counter;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;
  Future<List<Cart>> getData() async {
    _cart = db.getCartList();
    return _cart;
  }

  // void clearPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.clear();
  // }

  void _setPrefitems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('cart_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefitems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('cart_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefitems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefitems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefitems();
    return _counter;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice += productPrice;
    _setPrefitems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice -= productPrice;
    _setPrefitems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefitems();
    return _totalPrice;
  }
}
