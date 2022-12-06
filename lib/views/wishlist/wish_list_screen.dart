import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_models/wishlist_view_model.dart';
import 'components/wishlist_components.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<WishListViewModel>(context, listen: false)
          .fetchWishlistProduct(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const HeaderWishlist(),
            SizedBox(height: 30.h),
            const GridWishlistProduct(),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
