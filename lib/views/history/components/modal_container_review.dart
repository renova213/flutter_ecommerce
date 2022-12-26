import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../models/transaction_model.dart';
import '../../../view_models/review_view_model.dart';
import '../../widgets/widgets.dart';

class ModalContainerReview extends StatefulWidget {
  final TransactionProductModel product;
  const ModalContainerReview({super.key, required this.product});

  @override
  State<ModalContainerReview> createState() => _ModalContainerReviewState();
}

class _ModalContainerReviewState extends State<ModalContainerReview> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        Provider.of<ReviewViewModel>(context, listen: false).inputRating(5.0);
        Provider.of<ReviewViewModel>(context, listen: false).changeInput("");
        Provider.of<ReviewViewModel>(context, listen: false).clearRating();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final focusField = FocusNode();
    final double width = MediaQuery.of(context).size.width;
    return IntrinsicHeight(
      child: GestureDetector(
        onTap: () {
          focusField.unfocus();
          FocusScope.of(context).requestFocus(FocusNode());
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Container(
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  _closeButton(context),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Column(
                      children: [
                        _productDetail(widget.product),
                        SizedBox(height: 8.h),
                        _ratingBuilder(),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _satisfactionText(),
                  SizedBox(height: 8.h),
                  _textField(),
                  SizedBox(height: 8.h),
                  _containerPickImage(width),
                  SizedBox(height: 16.h),
                  Consumer<ReviewViewModel>(
                    builder: (context, review, _) => ButtonWidget(
                        buttonText: "Kirim",
                        height: 40,
                        width: width,
                        onpressed: () async {
                          try {
                            await review
                                .postReview(
                                    productId: widget.product.id,
                                    review: review.input,
                                    image: review.image,
                                    star: review.userRating.toInt().toString())
                                .then(
                                  (_) => Fluttertoast.showToast(
                                      msg: "Berhasil membuat review"),
                                )
                                .then(
                                  (_) => Navigator.pop(context),
                                );
                          } catch (e) {
                            Fluttertoast.showToast(msg: e.toString());
                          }
                        },
                        radius: 5,
                        fontSize: 16),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _closeButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close, size: 25.sp, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _productDetail(TransactionProductModel product) {
    return SizedBox(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl: product.image,
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
              height: 50.h,
              width: 50.w,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 3,
            child: Text(
              product.name,
              style:
                  AppFont.paragraphMedium.copyWith(fontWeight: FontWeight.w400),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBuilder() {
    return Center(
      child: Consumer<ReviewViewModel>(
        builder: (context, review, _) => RatingBar.builder(
          itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
          updateOnDrag: true,
          initialRating: 5,
          minRating: 1,
          maxRating: 5,
          itemBuilder: (context, _) =>
              Icon(Icons.star, color: Colors.yellow.shade900),
          onRatingUpdate: (value) {
            review.inputRating(value);
          },
        ),
      ),
    );
  }

  Widget _satisfactionText() {
    return Consumer<ReviewViewModel>(
      builder: (context, review, _) {
        return Text(review.satisfactionText, style: AppFont.paragraphLargeBold);
      },
    );
  }

  Widget _textField() {
    return Consumer<ReviewViewModel>(
      builder: (context, review, _) => TextField(
        onChanged: (value) {
          review.changeInput(value);
        },
        maxLength: 255,
        style: AppFont.paragraphMedium.copyWith(color: Colors.grey.shade900),
        cursorColor: Colors.grey,
        controller: review.reviewController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: review.hintText,
          hintStyle:
              AppFont.paragraphMedium.copyWith(color: Colors.grey.shade700),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          errorBorder: null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerPickImage(double width) {
    return SizedBox(
      width: width,
      height: 60.h,
      child: DashedRect(
        color: AppColor.thirdColor,
        strokeWidth: 1,
        gap: 2.0,
        child: Consumer<ReviewViewModel>(
          builder: (context, review, _) => InkWell(
            onTap: () {
              review.getImage();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.browse_gallery,
                    size: 24.sp, color: AppColor.thirdColor),
                SizedBox(width: 8.w),
                Text(
                  review.imageCheck,
                  style: AppFont.paragraphMedium
                      .copyWith(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
