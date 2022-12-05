import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../models/product_model.dart';
import '../../utils/utils.dart';
import '../../view_models/cart_view_model.dart';
import '../../view_models/wishlist_view_model.dart';
import '../detail_product/detail_product_screen.dart';

class ProductWidget extends StatefulWidget {
  final ProductDetailModel product;
  const ProductWidget({super.key, required this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          NavigatorFadeTransitionHelper(
            child: DetailProduct(product: widget.product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
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
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.product.image),
                      fit: BoxFit.fill),
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 4.h, left: 12.w, right: 12.w, bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                      child: Text(
                        widget.product.name,
                        style: AppFont.paragraphSmall
                            .copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20.h,
                            width: 100.w,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "Rp. ${widget.product.harga}",
                                style: AppFont.paragraphSmall.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red.shade600),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _modalAction(context, width);
                              },
                              child: Icon(Icons.more_vert, size: 17.sp),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
                            Text("Product Action",
                                style: AppFont.paragraphLargeBold),
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
                    Column(
                      children: [
                        Consumer<WishListViewModel>(
                          builder: (context, wishlist, _) => _containerAction(
                              nameAction: 'Add To Wishlist',
                              function: () async {
                                try {
                                  await wishlist
                                      .postWishList(
                                        idBarang: widget.product.id,
                                      )
                                      .then(
                                        (_) => Fluttertoast.showToast(
                                            msg:
                                                'Berhasil ditambahkan ke wishlist'),
                                      )
                                      .then(
                                        (_) => Navigator.pop(context),
                                      );
                                } catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                  Navigator.pop(context);
                                }
                              },
                              width: width),
                        ),
                        Consumer<CartViewModel>(
                          builder: (context, cart, _) => _containerAction(
                              nameAction: 'Add To Cart',
                              function: () async {
                                try {
                                  await cart
                                      .postCart(
                                          productId: widget.product.id,
                                          quantity: 1)
                                      .then(
                                        (_) => Fluttertoast.showToast(
                                                msg:
                                                    "Berhasil menambahkan produk ke keranjang")
                                            .then(
                                          (_) => Navigator.pop(context),
                                        ),
                                      );
                                } catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                }
                              },
                              width: width),
                        ),
                      ],
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

  Widget _containerAction(
      {required String nameAction,
      required void Function() function,
      required double width}) {
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
            child: Text(
              nameAction,
              style:
                  AppFont.paragraphMedium.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
