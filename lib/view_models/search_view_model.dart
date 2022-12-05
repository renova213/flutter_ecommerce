import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/apps_repository.dart';
import '../models/product_model.dart';
import '../utils/utils.dart';

class SearchProductViewModel extends ChangeNotifier {
  final AppsRepository repository = AppsRepository();

  final List<String> _recentSearch = [];
  final TextEditingController _searchController = TextEditingController();
  String _input = '';
  List<ProductDetailModel> _searchResult = [];
  AppState _appState = AppState.loading;
  int _selectedIndex = 0;

  List<String> get recentSearch => _recentSearch;
  TextEditingController get searchController => _searchController;
  String get input => _input;
  List<ProductDetailModel> get searchResult => _searchResult;
  AppState get appState => _appState;
  int get selectedIndex => _selectedIndex;

  void saveRecentSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userid');
    final search = prefs.getStringList('${userId}recentSearch');

    if (search != null) {
      for (var i = 0; i < search.length; i++) {
        if (!_recentSearch.contains(search[i])) {
          _recentSearch.add(search[i]);
          notifyListeners();
        }
      }
    }
    _input = '';
    _searchController.clear();
    notifyListeners();
  }

  void addRecentSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userid');

    if (_recentSearch.length >= 8) {
      removeRecentSearchByIndex(0);
    }

    if (!_recentSearch.contains(_searchController.text)) {
      _recentSearch.add(_searchController.text);
      notifyListeners();

      prefs.setStringList(
        "${userId}recentSearch",
        _recentSearch.map((e) => e).toList(),
      );

      notifyListeners();
    }
    notifyListeners();
  }

  void removeRecentSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userid');

    prefs.remove("${userId}recentSearch");
    _recentSearch.clear();

    notifyListeners();
  }

  void removeRecentSearchByIndex(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userid');

    _recentSearch.removeAt(index);
    prefs.setStringList(
      "${userId}recentSearch",
      _recentSearch.map((e) => e).toList(),
    );
    notifyListeners();
  }

  void changeinput(String input) {
    _input = input;
    notifyListeners();
  }

  void searchProduct() async {
    try {
      changeAppState(AppState.loading);

      _searchResult =
          await repository.filterProductByName(_searchController.text);
      changeAppState(AppState.loaded);

      if (_searchResult.isEmpty) {
        changeAppState(AppState.noData);
      }
    } catch (e) {
      changeAppState(AppState.failure);
    }
  }

  void searchProductByTap(String value) async {
    try {
      changeAppState(AppState.loading);

      _searchResult = await repository.filterProductByName(value);
      changeAppState(AppState.loaded);

      if (_searchResult.isEmpty) {
        changeAppState(AppState.noData);
      }
    } catch (e) {
      changeAppState(AppState.failure);
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
    _searchResult.sort(
      (a, b) => a.name.toLowerCase().compareTo(
            b.name.toLowerCase(),
          ),
    );
    notifyListeners();
  }

  void descendingSort() {
    _searchResult.sort(
      (a, b) => b.name.toLowerCase().compareTo(
            a.name.toLowerCase(),
          ),
    );
    notifyListeners();
  }

  void lowPriceSort() {
    _searchResult.sort(
      (a, b) => b.harga.toString().compareTo(
            a.harga.toString(),
          ),
    );
    notifyListeners();
  }

  void highPriceSort() {
    _searchResult.sort(
      (a, b) => a.harga.toString().compareTo(
            b.harga.toString(),
          ),
    );
    notifyListeners();
  }
}
