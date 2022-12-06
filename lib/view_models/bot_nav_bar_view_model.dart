import 'package:flutter/cupertino.dart';

import '../views/history/history_screen.dart';
import '../views/home/home_screen.dart';
import '../views/profile/profile_scree.dart';
import '../views/wishlist/wish_list_screen.dart';

class BotNavBarViewModel extends ChangeNotifier {
  final List<Widget> _pages = [
    const HomeScreen(),
    const WishListScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  List<Widget> get pages => _pages;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
