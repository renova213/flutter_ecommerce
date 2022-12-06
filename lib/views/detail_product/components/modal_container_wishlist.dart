import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../models/wishlist_model.dart';
import '../../../view_models/cart_view_model.dart';
import '../../widgets/widgets.dart';

class ModalContainerWishList extends StatefulWidget {
  final WishListProduct product;
  const ModalContainerWishList({super.key, required this.product});

  @override
  State<ModalContainerWishList> createState() => _ModalContainerState();
}

class _ModalContainerState extends State<ModalContainerWishList> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartViewModel>(context, listen: false).resetQuantity();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return IntrinsicHeight(
      child: Container(
        width: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        child: Material(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add to Cart", style: AppFont.paragraphLargeBold),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon:
                            Icon(Icons.close, size: 25.sp, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 27.h),
              _detailProduct(width),
              SizedBox(height: 27.h),
              _quantityProduct(),
              SizedBox(height: 61.h),
              Consumer<CartViewModel>(
                builder: (context, cart, _) => ButtonWidget(
                    buttonText: 'Confirm',
                    height: 45,
                    width: 220,
                    onpressed: () async {
                      try {
                        await cart
                            .postCart(
                                productId: widget.product.id,
                                quantity: cart.quantityProduct)
                            .then(
                              (_) => Fluttertoast.showToast(
                                      msg: "Berhasil ditambahkan ke keranjang")
                                  .then(
                                (_) => Navigator.pop(
                                  context,
                                ),
                              ),
                            );
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                    radius: 10,
                    fontSize: 18),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailProduct(double width) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffEDEDED), width: 2),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 32.w, bottom: 16.h),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100.h,
                width: 70.w,
                child: CachedNetworkImage(
                  imageUrl: widget.product.image,
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    );
                  },
                  placeholder: (context, url) {
                    return const SkeletonContainer(
                        height: 100, width: 70, borderRadius: 10);
                  },
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name, style: AppFont.paragraphLargeBold),
                  SizedBox(height: 15.h),
                  Text(
                    "Rp ${widget.product.harga}",
                    style: AppFont.paragraphMediumBold
                        .copyWith(color: AppColor.mainColor),
                  ),
                  SizedBox(height: 7.h),
                  Text(
                    'Stock : ${widget.product.stock}',
                    style: AppFont.paragraphMediumBold
                        .copyWith(color: const Color(0xffC4C4C4)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityProduct() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Quantity", style: AppFont.paragraphMediumBold),
        Consumer<CartViewModel>(
          builder: (context, checkout, _) => Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      checkout.minusQuantityProduct(
                          widget.product.stock, widget.product.harga);
                    },
                    child: SizedBox(
                      width: 25.w,
                      height: 25.h,
                      child: Icon(Icons.remove, size: 15.sp),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Text(checkout.quantityProduct.toString(),
                  style: AppFont.paragraphMediumBold),
              SizedBox(width: 15.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      checkout.plusQuantityProduct(
                          widget.product.stock, widget.product.harga);
                    },
                    child: SizedBox(
                      width: 25.w,
                      height: 25.h,
                      child: Icon(Icons.add, size: 15.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
