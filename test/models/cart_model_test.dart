import 'dart:convert';

import 'package:flutter_ecommerce/models/cart_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  CartModel testCartModel = CartModel(
      id: 0,
      cartProduct: CartProduct(
          id: 0,
          categoryId: 0,
          deskripsi: 'deskripsi',
          harga: 0,
          image: 'image',
          name: 'name',
          stock: 0),
      productId: 0,
      quantity: 0,
      userId: 0);

  group('fromJson', () {
    test('should return valid model CartModel from json', () {
      final jsonMap = json.decode(
        fixture('cart.json'),
      );

      final result =
          (jsonMap['data'] as List).map((e) => CartModel.fromJson(e)).toList();

      expect(result.first.cartProduct.name,
          equals(testCartModel.cartProduct.name));
    });
  });
}
