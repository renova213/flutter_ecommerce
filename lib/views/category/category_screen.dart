import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../utils/utils.dart';
import '../../view_models/category_product_view_model.dart.dart';
import '../widgets/widgets.dart';
import 'components/category_components.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryName;
  final String displayCategoryName;
  const CategoryScreen(
      {super.key,
      required this.categoryName,
      required this.displayCategoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoryProductViewModel>(context, listen: false)
          .fetchCategoryProduct(widget.categoryName);
      Provider.of<CategoryProductViewModel>(context, listen: false)
          .changeIndex(0);
      Provider.of<CategoryProductViewModel>(context, listen: false)
          .ascendingSort();
    });
  }

  @override
  Widget build(BuildContext context) {
    final focusField = FocusNode();

    final width = MediaQuery.of(context).size.width;
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
              HeaderCategory(category: widget.displayCategoryName),
              SizedBox(height: 16.h),
              _listProduct(),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ButtonWidget(
                    buttonText: 'Sorting',
                    height: 46.h,
                    width: width,
                    onpressed: () {
                      _modalAction(context, width);
                    },
                    radius: 10,
                    fontSize: 16),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listProduct() {
    return Consumer<CategoryProductViewModel>(
      builder: (context, category, _) {
        if (category.appState == AppState.loading) {
          return _loadingContainer();
        }

        if (category.appState == AppState.failure) {
          return Center(
            child: Text("Failed get product data from server",
                style: AppFont.paragraphMediumBold),
          );
        }

        if (category.appState == AppState.loaded) {
          return GridCategoryProduct(product: category.products);
        }

        if (category.appState == AppState.noData) {
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

  void _modalAction(BuildContext context, double width) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.grey[50],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 72.h,
                      width: width,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(color: Color(0xffEDEDED), width: 2),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.w, right: 16.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Sorting", style: AppFont.paragraphLargeBold),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.close,
                                      size: 25, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Consumer<CategoryProductViewModel>(
                      builder: (context, category, _) => Column(
                        children: [
                          _containerAction(
                              nameAction: 'Name (A-Z)',
                              function: () {
                                category.changeIndex(0);
                                category.ascendingSort();
                                Navigator.pop(context);
                              },
                              width: width,
                              index: 0),
                          _containerAction(
                              nameAction: 'Name (Z-A)',
                              function: () {
                                category.changeIndex(1);
                                category.descendingSort();
                                Navigator.pop(context);
                              },
                              width: width,
                              index: 1),
                          _containerAction(
                              nameAction: 'Price (Low-High)',
                              function: () {
                                category.changeIndex(2);
                                category.lowPriceSort();
                                Navigator.pop(context);
                              },
                              width: width,
                              index: 2),
                          _containerAction(
                              nameAction: 'Price (High-Low)',
                              function: () {
                                category.changeIndex(3);
                                category.highPriceSort();
                                Navigator.pop(context);
                              },
                              width: width,
                              index: 3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _containerAction(
      {required String nameAction,
      required void Function() function,
      required double width,
      required int index}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: function,
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 16.w),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 60.h,
            width: width,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xffEDEDED), width: 2),
              ),
            ),
            child: Consumer<CategoryProductViewModel>(
              builder: (context, category, _) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nameAction,
                    style: AppFont.paragraphMedium
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  category.selectedIndex == index
                      ? SvgPicture.asset('assets/icons/checklist.svg',
                          width: 30.w, height: 30.h)
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
