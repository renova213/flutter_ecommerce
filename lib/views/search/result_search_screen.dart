import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/search/search_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';
import '../../utils/utils.dart';
import 'components/search_components.dart';

class ResultSearchScreen extends StatelessWidget {
  const ResultSearchScreen({super.key});

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
          "Search",
          style: AppFont.paragraphLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        elevation: 0.3,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 32.h),
            SearchField(
              readOnly: true,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  NavigatorFadeTransitionHelper(
                    child: const SearchScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 32.h),
            const ListResultProduct(),
            SizedBox(height: 32.h),
            const SortingButtonSearch(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
