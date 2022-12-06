import 'package:flutter/cupertino.dart';

import '../data/repository/apps_repository.dart';
import '../models/transaction_model.dart';
import '../utils/utils.dart';

class TransactionViewModel extends ChangeNotifier {
  final AppsRepository appsRepository = AppsRepository();

  List<TransactionModel> _transactions = [];
  AppState _appState = AppState.loading;

  List<TransactionModel> get transactions => _transactions;
  AppState get appState => _appState;

  Future<void> postTransaction(String address) async {
    try {
      await appsRepository.postTransaction(address);
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> fetchTransaction() async {
    try {
      changeAppState(AppState.loading);
      _transactions = await appsRepository.fetchTransaction();
      _transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      changeAppState(AppState.loaded);

      if (_transactions.isEmpty) {
        changeAppState(AppState.noData);
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
