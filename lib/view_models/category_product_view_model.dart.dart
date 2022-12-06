import 'package:flutter/cupertino.dart';

import '../data/repository/apps_repository.dart';
import '../models/product_model.dart';
import '../utils/utils.dart';

class CategoryProductViewModel extends ChangeNotifier {
  final AppsRepository appsRepository = AppsRepository();

  List<ProductDetailModel> _products = [];
  AppState _appState = AppState.loading;
  int _selectedIndex = 0;

  List<ProductDetailModel> get products => _products;
  AppState get appState => _appState;
  int get selectedIndex => _selectedIndex;

  void fetchCategoryProduct(String value) async {
    _products.clear();
    try {
      changeAppState(AppState.loading);
      _products = await appsRepository.fetchCategoryProduct(value);
      notifyListeners();
      changeAppState(AppState.loaded);

      if (_products.isEmpty) {
        changeAppState(AppState.noData);
      }
    } catch (e) {
      changeAppState(AppState.failure);
      rethrow;
    }
  }

  void changeIndex(int index) {
    if (_selectedIndex == 0 && index == 0) {
    } else {
      _selectedIndex = index;
    }
  }

  void changeAppState(AppState appState) {
    _appState = appState;
    notifyListeners();
  }

  void ascendingSort() {
    _products.sort(
      (a, b) => a.name.toLowerCase().compareTo(
            b.name.toLowerCase(),
          ),
    );
    notifyListeners();
  }

  void descendingSort() {
    _products.sort(
      (a, b) => b.name.toLowerCase().compareTo(
            a.name.toLowerCase(),
          ),
    );
    notifyListeners();
  }

  void lowPriceSort() {
    _products.sort(
      (a, b) => b.harga.toString().compareTo(
            a.harga.toString(),
          ),
    );
    notifyListeners();
  }

  void highPriceSort() {
    _products.sort(
      (a, b) => a.harga.toString().compareTo(
            b.harga.toString(),
          ),
    );
    notifyListeners();
  }
}
