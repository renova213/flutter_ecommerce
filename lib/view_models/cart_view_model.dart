import 'package:flutter/cupertino.dart';

import '../data/repository/apps_repository.dart';
import '../models/cart_model.dart';
import '../utils/utils.dart';

class CartViewModel extends ChangeNotifier {
  final AppsRepository appsRepository = AppsRepository();

  List<CartModel> _carts = [];
  AppState _appState = AppState.loading;
  int _sumPriceProducts = 0;
  int _quantityProduct = 1;

  List<CartModel> get carts => _carts;
  AppState get appState => _appState;
  int get sumPriceProducts => _sumPriceProducts;
  int get quantityProduct => _quantityProduct;

  void fetchCart() async {
    try {
      changeAppState(AppState.loading);
      _carts = await appsRepository.fetchCart();
      sumPrices();
      changeAppState(AppState.loaded);

      if (_carts.isEmpty) {
        changeAppState(AppState.noData);
      }
    } catch (e) {
      changeAppState(AppState.failure);
      rethrow;
    }
  }

  Future<void> postCart({required int productId, required int quantity}) async {
    try {
      await appsRepository.postCart(productId: productId, quantity: quantity);
      fetchCart();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCart(int productId) async {
    try {
      await appsRepository.deleteCart(productId);
      fetchCart();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void changeAppState(AppState appState) {
    _appState = appState;
    notifyListeners();
  }

  void sumPrices() {
    _sumPriceProducts = 0;
    notifyListeners();

    for (var i in _carts) {
      _sumPriceProducts += i.cartProduct.harga * i.quantity;
      notifyListeners();
    }
  }

  void plusQuantityProduct(int productStock, int hargaProduct) {
    if (_quantityProduct < productStock) {
      _quantityProduct++;
    }
    notifyListeners();
  }

  void minusQuantityProduct(int productStock, int hargaProduct) {
    if (_quantityProduct > 1) {
      _quantityProduct--;
    }
    notifyListeners();
  }

  void resetQuantity() {
    _quantityProduct = 1;
  }
}
