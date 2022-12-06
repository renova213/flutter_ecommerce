import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../../../view_models/search_view_model.dart';
import '../../widgets/widgets.dart';

class ListResultProduct extends StatelessWidget {
  const ListResultProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Consumer<SearchProductViewModel>(
        builder: (context, search, _) {
          if (search.appState == AppState.loaded) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: search.searchResult.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1 / 1.3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12),
              itemBuilder: (context, index) {
                final data = search.searchResult[index];
                return ProductWidget(product: data);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
