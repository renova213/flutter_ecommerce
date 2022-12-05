import 'package:flutter/cupertino.dart';

import '../data/repository/apps_repository.dart';
import '../models/product_model.dart';
import '../utils/utils.dart';

class FeaturedProductViewModel extends ChangeNotifier {
  final AppsRepository appsRepository = AppsRepository();

  final List<ProductDetailModel> _featuredProduct = [];
  AppState _appState = AppState.loading;

  List<ProductDetailModel> get featuredProduct => _featuredProduct;
  AppState get appState => _appState;

  void filterCategoryProduct() async {
    try {
      changeAppState(AppState.loading);
      final List<ProductDetailModel> products =
          await appsRepository.fetchProduct();

      for (var i in products) {
        if (i.productCategory.name == 'k-4-1_featured' &&
            !_featuredProduct.contains(i)) {
          _featuredProduct.add(i);
          notifyListeners();
        }
      }

      changeAppState(AppState.loaded);
      notifyListeners();
      if (_featuredProduct.isEmpty) {
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
