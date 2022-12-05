import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';
import '../../../view_models/cart_view_model.dart';
import '../../widgets/widgets.dart';

class ListCart extends StatelessWidget {
  const ListCart({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Consumer<CartViewModel>(
        builder: (context, cart, _) {
          if (cart.appState == AppState.loading) {
            return _loadingContainer(width);
          }
          if (cart.appState == AppState.failure) {}
          if (cart.appState == AppState.loaded) {
            return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = cart.carts[index];

                  return Container(
                    width: width,
                    height: 115.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.3), width: 2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _cartImage(data.cartProduct.image),
                          ),
                          Expanded(
                            flex: 3,
                            child: _cartDetailProduct(
                                nameProduct: data.cartProduct.name,
                                price: data.cartProduct.harga,
                                quantity: data.quantity),
                          ),
                          Expanded(
                            flex: 1,
                            child: _deleteCart(data.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 24.h),
                itemCount: cart.carts.length);
          }
          if (cart.appState == AppState.noData) {}

          return const SizedBox();
        },
      ),
    );
  }

  Widget _loadingContainer(double width) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 24.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) =>
          SkeletonContainer(width: width, height: 115, borderRadius: 10),
    );
  }

  Widget _deleteCart(int productId) {
    return SizedBox(
      width: 30.w,
      height: 30.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Material(
          color: Colors.transparent,
          child: Consumer<CartViewModel>(
            builder: (context, cart, _) => InkWell(
              onTap: () async {
                try {
                  await cart.deleteCart(productId).then(
                        (_) => Fluttertoast.showToast(
                            msg: "Item ini berhasil dihapus dari keranjang"),
                      );
                } catch (e) {
                  Fluttertoast.showToast(msg: e.toString());
                }
              },
              child: Icon(Icons.delete, color: Colors.grey, size: 24.sp),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cartDetailProduct(
      {required String nameProduct,
      required int price,
      required int quantity}) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nameProduct,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppFont.paragraphSmallBold),
          SizedBox(height: 8.h),
          Text(
            "Rp ${price * quantity}",
            style:
                AppFont.paragraphSmallBold.copyWith(color: AppColor.mainColor),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Consumer<CartViewModel>(
              builder: (context, cart, _) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text("Quantity : $quantity",
                        style: AppFont.paragraphSmall),
                  )),
        ],
      ),
    );
  }

  Widget _cartImage(String urlImage) {
    return CachedNetworkImage(
      imageUrl: urlImage,
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
    );
  }
}
