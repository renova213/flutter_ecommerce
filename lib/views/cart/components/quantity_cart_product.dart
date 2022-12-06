import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../view_models/cart_view_model.dart';

class QuantityCartProduct extends StatelessWidget {
  const QuantityCartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cart, _) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Products",
              style: AppFont.paragraphMedium.copyWith(
                color: const Color(0xff888888),
              ),
            ),
            Text(
              cart.carts.length.toString(),
              style: AppFont.paragraphMedium.copyWith(
                color: const Color(0xff888888),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
