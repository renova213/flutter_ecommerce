import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../models/wishlist_model.dart';
import '../../utils/utils.dart';
import '../../view_models/review_view_model.dart';
import '../../view_models/wishlist_view_model.dart';
import '../review/review_screen.dart';
import '../widgets/widgets.dart';
import 'components/detail_components.dart';

class DetailWishlistProductScreen extends StatefulWidget {
  final WishListProduct product;
  const DetailWishlistProductScreen({super.key, required this.product});

  @override
  State<DetailWishlistProductScreen> createState() =>
      _DetailWishlistProductScreenState();
}

class _DetailWishlistProductScreenState
    extends State<DetailWishlistProductScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ReviewViewModel>(context, listen: false)
          .fetchReviews(widget.product.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 330.h,
              child: Stack(
                children: [
                  _headerProduct(context),
                  Positioned(
                    top: 70.h,
                    child: SizedBox(
                      height: 270.h,
                      width: 250.w,
                      child: CachedNetworkImage(
                        imageUrl: widget.product.image,
                        errorWidget: (context, url, error) {
                          return const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          );
                        },
                        placeholder: (context, url) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            _detailProduct(),
            SizedBox(height: 40.h),
            _buttonChartAndWishlist(context),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _headerProduct(BuildContext context) {
    return Container(
      height: 280.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.mainColor, AppColor.thirdColor],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  SizedBox(width: 200.w),
                  const Spacer(),
                  SizedBox(
                    width: 120.w,
                    height: 150.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 50.h,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(widget.product.name,
                                  textAlign: TextAlign.right,
                                  style: AppFont.paragraphLargeBold),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Price",
                            textAlign: TextAlign.right,
                            style: AppFont.paragraphSmall.copyWith(
                              color: const Color(0xffD9D9D9),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "Rp ${widget.product.harga}",
                              textAlign: TextAlign.right,
                              style: AppFont.paragraphLargeBold.copyWith(
                                color: AppColor.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailProduct() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Consumer<ReviewViewModel>(
                builder: (context, review, _) {
                  if (review.appState == AppState.loading) {
                    return const SkeletonContainer(
                        width: 100, height: 10, borderRadius: 0);
                  }

                  return Row(
                    children: [
                      RatingBarIndicator(
                        itemSize: 16.sp,
                        rating: review.reviews.isEmpty
                            ? 0.0
                            : double.parse(
                                review.averageSumRating.toStringAsPrecision(2)),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        review.reviews.isEmpty
                            ? '0.0'
                            : review.averageSumRating.toStringAsPrecision(2),
                        style: AppFont.paragraphMedium
                            .copyWith(color: Colors.yellow.shade600),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              Consumer<ReviewViewModel>(
                builder: (context, review, _) => review.reviews.isEmpty
                    ? Text(
                        "Belum Ada Review",
                        style: AppFont.paragraphMedium.copyWith(
                          color: const Color(0xff888888),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            NavigatorFadeTransitionHelper(
                              child: ReviewScreen(product: widget.product),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Consumer<ReviewViewModel>(
                              builder: (context, review, _) {
                                if (review.appState == AppState.loading) {
                                  return const SkeletonContainer(
                                      width: 80, height: 10, borderRadius: 0);
                                }

                                return Text(
                                  "${review.reviews.length} reviews",
                                  style: AppFont.paragraphMedium.copyWith(
                                    color: const Color(0xff888888),
                                  ),
                                );
                              },
                            ),
                            Icon(Icons.keyboard_arrow_right, size: 16.sp),
                          ],
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Text(widget.product.name, style: AppFont.componentLarge),
          SizedBox(height: 20.h),
          Text(
            widget.product.deskripsi,
            textAlign: TextAlign.justify,
            style: AppFont.paragraphSmall.copyWith(
              color: const Color(0xff888888),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonChartAndWishlist(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonWidget(
            buttonText: 'ADD TO CART',
            height: 50,
            width: 240,
            radius: 10,
            fontSize: 14,
            onpressed: () {
              _addToCartBottomSheet(context);
            },
          ),
          Consumer<WishListViewModel>(
            builder: (context, wishlist, _) => IconButtonWidget(
              iconAsset: 'assets/icons/shopping_bag.svg',
              height: 55,
              width: 50,
              radius: 100,
              widthIcon: 30,
              heightIcon: 30,
              onpressed: () async {
                try {
                  await wishlist
                      .postWishList(
                        idBarang: widget.product.id,
                      )
                      .then(
                        (_) => Fluttertoast.showToast(
                            msg: 'Berhasil ditambahkan ke wishlist'),
                      );
                } catch (e) {
                  Fluttertoast.showToast(msg: e.toString());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addToCartBottomSheet(BuildContext context) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: ModalContainerWishList(product: widget.product),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
}
