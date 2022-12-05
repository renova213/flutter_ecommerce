import 'dart:convert';

import 'package:flutter_ecommerce/models/wishlist_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  WishListModel testWishlistModel = WishListModel(
      id: 0,
      product: WishListProduct(
          id: 0,
          name: 'name',
          categoryId: 0,
          image: 'image',
          harga: 0,
          deskripsi: 'deskripsi',
          stock: 0,
          createDate: 'created_at'),
      userId: 0,
      productId: 0);

  group('fromJson', () {
    test('should return valid model WishlistModel from json', () {
      final jsonMap = json.decode(
        fixture('wishlist.json'),
      );

      final result = (jsonMap['data'] as List)
          .map((e) => WishListModel.fromJson(e))
          .toList();

      expect(result.first.id, equals(testWishlistModel.id));
    });
  });
}
