import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';
import '../../models/transaction_model.dart';
import 'components/history_components.dart';

class DetailTransactionScreen extends StatelessWidget {
  final List<TransactionProductModel> product;
  const DetailTransactionScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
        ),
        title: Text(
          "Detail Pesanan",
          style: AppFont.paragraphLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        elevation: 0.3,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              Text("Detail Produk", style: AppFont.paragraphLargeBold),
              SizedBox(height: 32.h),
              ListDetialProduct(product: product),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
