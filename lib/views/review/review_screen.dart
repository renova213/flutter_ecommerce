import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../models/review_model.dart';
import '../../view_models/review_view_model.dart';
import '../../view_models/user_view_model.dart';
import '../widgets/widgets.dart';
import 'components/review_components.dart';

class ReviewScreen extends StatefulWidget {
  final dynamic product;
  const ReviewScreen({super.key, required this.product});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
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
      appBar: AppBar(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.keyboard_arrow_left),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Review Product",
          style: AppFont.paragraphLarge.copyWith(fontWeight: FontWeight.w500),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0.5,
        actions: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow.shade700, size: 20.sp),
              SizedBox(width: 4.w),
              Consumer<ReviewViewModel>(
                builder: (context, review, _) => Text(
                  review.averageSumRating.toStringAsFixed(1),
                  style: AppFont.paragraphLarge
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 16.w),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: 30.h),
              _numberRatings(),
              SizedBox(height: 40.h),
              _listReviews(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberRatings() {
    return SizedBox(
      height: 135.h,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Consumer<ReviewViewModel>(
          builder: (context, review, _) => Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 150.h,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0xFFEDEDED), width: 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: review.averageSumRating
                                    .toStringAsPrecision(2)
                                    .toString(),
                                style: AppFont.heading1),
                            TextSpan(
                                text: ' / 5', style: AppFont.paragraphMedium),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text("${review.reviews.length} Reviews",
                          style: AppFont.paragraphMedium),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ratingNumber(5.0, review.fiveRatingReviews.length,
                        review.averageRating5),
                    SizedBox(height: 8.h),
                    _ratingNumber(4.0, review.fourRatingReviews.length,
                        review.averageRating4),
                    SizedBox(height: 8.h),
                    _ratingNumber(3.0, review.threeRatingReviews.length,
                        review.averageRating3),
                    SizedBox(height: 8.h),
                    _ratingNumber(2.0, review.twoRatingReviews.length,
                        review.averageRating2),
                    SizedBox(height: 8.h),
                    _ratingNumber(1.0, review.oneRatingReviews.length,
                        review.averageRating1),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ratingNumber(
      double rating, int jumlahReview, double percentageRating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RatingBarIndicator(
          itemSize: 15.sp,
          rating: rating,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.yellow.shade700,
          ),
        ),
        SizedBox(width: 6.w),
        Stack(
          children: [
            Container(
              height: 4.h,
              width: 90.w,
              decoration: BoxDecoration(
                color: const Color(0XFFEDEDED),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 4.h,
              width: 90.w * percentageRating,
              decoration: BoxDecoration(
                color: Colors.yellow.shade700,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Container(
          alignment: Alignment.centerRight,
          width: 20.w,
          child: Text(
            jumlahReview.toString(),
            style: AppFont.paragraphSmall.copyWith(fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _listReviews() {
    return Consumer<ReviewViewModel>(
      builder: (context, review, _) => ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 24.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: review.reviews.length,
        itemBuilder: (context, index) {
          final data = review.reviews[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  data.user.name[0].toUpperCase(),
                  style:
                      AppFont.paragraphLargeBold.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(width: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.user.name,
                          style: AppFont.paragraphMedium
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Consumer<UserViewModel>(
                          builder: (context, user, _) => data.userId ==
                                  user.user.id
                              ? PopupMenuButton(
                                  offset: const Offset(0, 20),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 0,
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete,
                                              size: 20.sp, color: Colors.grey),
                                          SizedBox(width: 8.w),
                                          Text("Delete Review",
                                              style: AppFont.paragraphMedium),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit,
                                              size: 20.sp, color: Colors.grey),
                                          SizedBox(width: 8.w),
                                          Text("Edit Review",
                                              style: AppFont.paragraphMedium),
                                        ],
                                      ),
                                    ),
                                  ],
                                  onSelected: (value) async {
                                    if (value == 1) {
                                      _reviewDialog(context, data);
                                    }

                                    if (value == 0) {
                                      try {
                                        await review
                                            .deleteReview(
                                                reviewId: data.id,
                                                productId: data.productId)
                                            .then(
                                              (value) => Fluttertoast.showToast(
                                                msg:
                                                    "Berhasil Menghapus Review",
                                              ),
                                            );
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: e.toString());
                                      }
                                    }
                                  },
                                  child: Icon(Icons.more_vert, size: 20.sp),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  RatingBarIndicator(
                    itemSize: 15.sp,
                    rating: data.star.toDouble(),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: 250.w,
                    child: Text(data.review,
                        style: AppFont.paragraphSmall,
                        textAlign: TextAlign.justify),
                  ),
                  SizedBox(height: 12.h),
                  CachedNetworkImage(
                    imageUrl: data.image,
                    errorWidget: (context, url, error) {
                      return const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      );
                    },
                    placeholder: (context, url) {
                      return const SkeletonContainer(
                          width: 50, height: 50, borderRadius: 0);
                    },
                    height: 50.h,
                    width: 50.w,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _reviewDialog(BuildContext context, ReviewModel data) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: ModalEditReview(product: widget.product, review: data),
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
