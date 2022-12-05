import 'package:flutter/cupertino.dart';

import '../data/repository/apps_repository.dart';
import '../models/product_model.dart';
import '../utils/utils.dart';

class TopRatedProductViewModel extends ChangeNotifier {
  final AppsRepository appsRepository = AppsRepository();

  final List<ProductDetailModel> _topRatedProduct = [];
  AppState _appState = AppState.loading;

  List<ProductDetailModel> get topRatedProduct => _topRatedProduct;
  AppState get appState => _appState;

  void filterCategoryProduct() async {
    try {
      changeAppState(AppState.loading);
      final List<ProductDetailModel> products =
          await appsRepository.fetchProduct();

      for (var i in products) {
        if (i.productCategory.name == 'k-4-1_toprated' &&
            !_topRatedProduct.contains(i)) {
          _topRatedProduct.add(i);
          notifyListeners();
        }
        notifyListeners();
      }

      changeAppState(AppState.loaded);
      notifyListeners();
      if (_topRatedProduct.isEmpty) {
        changeAppState(AppState.noData);
        notifyListeners();
      }
    } catch (e) {
      changeAppState(AppState.failure);
      rethrow;
    }
  }

  void changeAppState(AppState appState) {
    _appState = appState;
    notifyListeners();
  }
}
