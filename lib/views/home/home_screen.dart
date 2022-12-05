import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/config.dart';
import '../../utils/utils.dart';
import '../../view_models/best_seller_product_view_model.dart';
import '../../view_models/featured_product_view_model.dart';
import '../../view_models/top_rated_product_view_model.dart';
import '../category/category_screen.dart';
import '../widgets/widgets.dart';
import 'components/home_components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        Provider.of<TopRatedProductViewModel>(context, listen: false)
            .filterCategoryProduct();
        Provider.of<BestSellerProductViewModel>(context, listen: false)
            .filterCategoryProduct();
        Provider.of<FeaturedProductViewModel>(context, listen: false)
            .filterCategoryProduct();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final focusField = FocusNode();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          focusField.unfocus();
          FocusScope.of(context).requestFocus(FocusNode());
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderHome(),
              SizedBox(height: 30.h),
              const CategoriesHome(),
              SizedBox(height: 40.h),
              _featuredProduct(),
              SizedBox(
                height: 36.h,
              ),
              BannerProduct(
                  nameBanner: 'New Era - Handphone',
                  assetImage: 'assets/images/hp.png',
                  onTap: () {
                    Navigator.of(context).push(
                      NavigatorFadeTransitionHelper(
                        child: const CategoryScreen(
                            categoryName: 'gadget',
                            displayCategoryName: 'New Era - Handphone'),
                      ),
                    );
                  },
                  color: AppColor.secondColor),
              SizedBox(height: 30.h),
              _besetSellerProduct(),
              SizedBox(height: 30.h),
              BannerProduct(
                  nameBanner: 'Save Your Power',
                  assetImage: 'assets/images/power_bank.png',
                  onTap: () {
                    Navigator.of(context).push(
                      NavigatorFadeTransitionHelper(
                        child: const CategoryScreen(
                            categoryName: 'powerbank',
                            displayCategoryName: 'Save Your Power'),
                      ),
                    );
                  },
                  color: AppColor.thirdColor),
              SizedBox(height: 30.h),
              _topRatedProduct(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featuredProduct() {
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

  Widget _besetSellerProduct() {
    return Consumer<BestSellerProductViewModel>(
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
                        categoryName: 'bestseller',
                        displayCategoryName: 'Best Seller'),
                  ),
                );
              },
              productCategory: 'Best Seller',
              product: product.bestSellerProduct);
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

  Widget _topRatedProduct() {
    return Consumer<TopRatedProductViewModel>(
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
                      categoryName: 'toprated',
                      displayCategoryName: 'Top Rated',
                    ),
                  ),
                );
              },
              productCategory: 'Top Rated',
              product: product.topRatedProduct);
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
