import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';
import '../../../view_models/wishlist_view_model.dart';
import '../../widgets/widgets.dart';
import 'wish_list_product.dart';

class GridWishlistProduct extends StatelessWidget {
  const GridWishlistProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Consumer<WishListViewModel>(
        builder: (context, wishlist, _) {
          if (wishlist.appState == AppState.loading) {
            return _loadingContainer();
          }

          if (wishlist.appState == AppState.loaded) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: wishlist.wishListProduct.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12),
              itemBuilder: (context, index) {
                final data = wishlist.wishListProduct[index];
                return WishListProductCard(wishList: data);
              },
            );
          }

          if (wishlist.appState == AppState.noData) {
            return Center(
              child: Text("Wishlist Product Is Empty",
                  style: AppFont.paragraphLargeBold),
            );
          }
          if (wishlist.appState == AppState.failure) {
            return Center(
              child: Text("Failed Get Wishlist Product Data",
                  style: AppFont.paragraphLargeBold),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _loadingContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.3,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        itemBuilder: (context, index) =>
            const SkeletonContainer(width: 150, height: 250, borderRadius: 20),
      ),
    );
  }
}
