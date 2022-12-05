import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../models/category_icon_model.dart';
import '../../../utils/utils.dart';
import '../../../view_models/product_view_model.dart';
import '../../category/category_screen.dart';

class CategoriesHome extends StatelessWidget {
  const CategoriesHome({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: AppFont.paragraphLarge
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: () {
                  _modalCategory(context, width);
                },
                child: Text(
                  "See all",
                  style: AppFont.paragraphLarge
                      .copyWith(color: AppColor.secondColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Align(
              child: _listCategory(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listCategory() {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          final data = CategoryIconModel.categoriesIcon[index];

          return SizedBox(
            width: 50.w,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(100.sp),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      NavigatorFadeTransitionHelper(
                        child: CategoryScreen(
                            categoryName: data.name,
                            displayCategoryName: data.name),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 35.w,
                        height: 35.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: data.color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: SvgPicture.asset(data.assetIcon,
                            width: 20.w, height: 20.h),
                      ),
                      SizedBox(height: 4.h),
                      SizedBox(
                        height: 20.h,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            data.name,
                            style: AppFont.paragraphSmall
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _modalCategory(BuildContext context, double width) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.grey[50],
              ),
              child: Consumer<ProductViewModel>(
                builder: (context, notifier, _) => SingleChildScrollView(
                  scrollDirection: Axis.vertical,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "All Categories",
                                style: AppFont.paragraphLarge
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
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
                      const SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    CategoryIconModel.categoriesIcon.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 40.h,
                                        crossAxisCount: 5),
                                itemBuilder: (context, index) {
                                  final data =
                                      CategoryIconModel.categoriesIcon[index];

                                  return SizedBox(
                                    width: 50.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  NavigatorFadeTransitionHelper(
                                                    child: CategoryScreen(
                                                        categoryName: data.name,
                                                        displayCategoryName:
                                                            data.name),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 35.w,
                                                height: 35.h,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: data.color
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: SvgPicture.asset(
                                                    data.assetIcon,
                                                    width: 20.w,
                                                    height: 20.h),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        SizedBox(
                                          height: 20.h,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              data.name,
                                              style: AppFont.paragraphSmall
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
