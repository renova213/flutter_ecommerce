import 'package:flutter/cupertino.dart';

import '../data/repository/apps_repository.dart';
import '../models/wishlist_model.dart';
import '../utils/utils.dart';

class WishListViewModel extends ChangeNotifier {
  final AppsRepository appsRepository = AppsRepository();
  List<WishListModel> _wishListProduct = [];
  AppState _appState = AppState.loading;

  List<WishListModel> get wishListProduct => _wishListProduct;
  AppState get appState => _appState;

  void changeAppState(AppState appState) {
    _appState = appState;
    notifyListeners();
  }

  void fetchWishlistProduct() async {
    try {
      changeAppState(AppState.loading);
      _wishListProduct = await appsRepository.fetchWishlistProduct();
      notifyListeners();
      changeAppState(AppState.loaded);

      if (_wishListProduct.isEmpty) {
        changeAppState(AppState.noData);
      }
    } catch (e) {
      changeAppState(AppState.failure);
      rethrow;
    }
  }

  Future<void> postWishList({required int idBarang}) async {
    try {
      await appsRepository.postWishlist(idBarang);
      fetchWishlistProduct();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWishList(int id) async {
    try {
      await appsRepository.deleteWishlist(id);
      fetchWishlistProduct();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
