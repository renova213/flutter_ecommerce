import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';
import '../../../view_models/featured_product_view_model.dart';
import '../../category/category_screen.dart';
import '../../home/components/grid_home_product.dart';
import '../../widgets/widgets.dart';

class FeaturedProductRecommendation extends StatelessWidget {
  const FeaturedProductRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FeaturedProductViewModel>(
      builder: (context, product, _) {
        if (product.appState == AppState.loading) {
          return _loadingContainer();
        }

        if (product.appState == AppState.failure) {
          return Center(
            child: Text("Failed get product data from server",
                style: AppFont.paragraphMediumBold),
          );
        }

        if (product.appState == AppState.loaded) {
          return GridHomeProduct(
              onTap: () {
                Navigator.of(context).push(
                  NavigatorFadeTransitionHelper(
                    child: const CategoryScreen(
                        categoryName: 'featured',
                        displayCategoryName: 'featured product'),
                  ),
                );
              },
              productCategory: 'Featured Product',
              product: product.featuredProduct);
        }

        if (product.appState == AppState.noData) {
          return Center(
            child: Text("Product is empty", style: AppFont.paragraphMediumBold),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _loadingContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
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
