import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/config.dart';
import '../../../models/transaction_model.dart';
import '../../../models/wishlist_model.dart';
import '../../../utils/utils.dart';
import '../../detail_product/detail_wishlist_product_screen.dart';
import 'history_components.dart';

class ListDetialProduct extends StatelessWidget {
  final List<TransactionProductModel> product;
  const ListDetialProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final data = product[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              NavigatorFadeTransitionHelper(
                child: DetailWishlistProductScreen(
                  product: WishListProduct(
                    id: data.id,
                    name: data.name,
                    categoryId: data.categoryId,
                    image: data.image,
                    harga: data.harga,
                    deskripsi: data.description,
                    stock: data.stock,
                    createDate: data.createdAt,
                  ),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 4,
                ),
              ],
            ),
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  _productInfo(data),
                  SizedBox(height: 16.h),
                  _priceAndButton(data, context),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemCount: product.length,
    );
  }

  Widget _productInfo(TransactionProductModel data) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: data.image,
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
          ),
          SizedBox(width: 16.w),
          Expanded(
            flex: 4,
            child: SizedBox(
              width: 230.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name,
                      style: AppFont.paragraphSmallBold,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 4.h),
                  Text(
                    "${data.pivotTransaction.quantity} x Rp ${data.harga}",
                    style: AppFont.componentSmall
                        .copyWith(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _priceAndButton(TransactionProductModel data, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Belanja",
              style:
                  AppFont.componentSmall.copyWith(color: Colors.grey.shade600),
            ),
            SizedBox(height: 4.h),
            Text("Rp ${data.pivotTransaction.quantity * data.harga}",
                style: AppFont.paragraphSmallBold,
                overflow: TextOverflow.ellipsis),
          ],
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.secondColor),
          ),
          child: SizedBox(
            height: 30.h,
            width: 80.w,
            child: TextButton(
              onPressed: () {
                _reviewDialog(context, data);
              },
              child: Text(
                "Beri Review",
                style: AppFont.paragraphSmall
                    .copyWith(color: AppColor.secondColor),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _reviewDialog(BuildContext context, TransactionProductModel data) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: ModalContainerReview(product: data),
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
