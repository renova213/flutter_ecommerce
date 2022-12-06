import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../models/transaction_model.dart';
import '../../../utils/utils.dart';
import '../../../view_models/transaction_view_model.dart';
import '../../widgets/widgets.dart';
import '../detail_transaction_screen.dart';

class ListTransaction extends StatelessWidget {
  const ListTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Consumer<TransactionViewModel>(
      builder: (context, transaction, _) {
        if (transaction.appState == AppState.loading) {
          return _loadingContainer(width);
        }
        if (transaction.appState == AppState.failure) {
          return Center(
            child: Text("Failed get transaction data",
                style: AppFont.paragraphLargeBold),
          );
        }
        if (transaction.appState == AppState.loaded) {
          return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = transaction.transactions[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                          _statusProduct(width, data),
                          SizedBox(height: 16.h),
                          _productInfo(data),
                          data.transactionProduct.length > 1
                              ? _moreProductInfo(data)
                              : SizedBox(height: 16.h),
                          _priceAndButton(data, context),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: transaction.transactions.length);
        }
        if (transaction.appState == AppState.noData) {
          return Center(
            child:
                Text("No data transaction", style: AppFont.paragraphLargeBold),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _statusProduct(double width, TransactionModel data) {
    return Container(
      width: width,
      height: 35.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        children: [
          Column(
            children: [
              SvgPicture.asset('assets/icons/shopping_bag.svg',
                  color: AppColor.thirdColor, width: 25.w, height: 25.h),
              SizedBox(height: 0.h),
            ],
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Belanja",
                style: AppFont.componentSmall
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4.h),
              Text(
                data.createdAt.substring(0, 11),
                style: AppFont.componentSmall
                    .copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Container(
                height: 20.h,
                width: 60.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data.status == "paid"
                      ? AppColor.secondColor
                      : Colors.red.shade500,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  data.status.replaceFirst(
                    data.status[0],
                    data.status[0].toUpperCase(),
                  ),
                  style: AppFont.componentSmall.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              SizedBox(height: 0.h),
            ],
          )
        ],
      ),
    );
  }

  Widget _productInfo(TransactionModel data) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: data.transactionProduct.first.image,
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
                  Text(data.transactionProduct.first.name,
                      style: AppFont.paragraphSmallBold,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 4.h),
                  Text(
                    "${data.transactionProduct.first.pivotTransaction.quantity.toString()} barang",
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

  Widget _priceAndButton(TransactionModel data, BuildContext context) {
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
            Text("Rp ${data.total}",
                style: AppFont.paragraphSmallBold,
                overflow: TextOverflow.ellipsis),
          ],
        ),
        data.status == "paid"
            ? ButtonWidget(
                buttonText: "Lihat Detail",
                height: 25,
                width: 90,
                onpressed: () {
                  Navigator.of(context).push(
                    NavigatorFadeTransitionHelper(
                      child: DetailTransactionScreen(
                          product: data.transactionProduct),
                    ),
                  );
                },
                radius: 5,
                fontSize: 12)
            : const SizedBox(),
      ],
    );
  }

  _loadingContainer(double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              SkeletonContainer(width: width, height: 150.h, borderRadius: 10),
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemCount: 3),
    );
  }

  Widget _moreProductInfo(TransactionModel data) {
    return Column(
      children: [
        SizedBox(height: 8.h),
        Text(
          "+${data.transactionProduct.length - 1} produk lainnya",
          style: AppFont.componentSmall.copyWith(color: Colors.grey.shade600),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
