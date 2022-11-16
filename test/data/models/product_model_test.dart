import 'dart:convert';

import 'package:flutter_ecommerce/data/models/product_model.dart';
import 'package:flutter_ecommerce/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const testProductModel = ProductModel(
    product: [
      ProductDetailModel(
        id: 0,
        name: 'name',
        categoryId: 0,
        image: 'image',
        harga: 0,
        deskripsi: 'deskripsi',
        stock: 0,
        createDate: 'created_at',
        productCategory: ProductCategoryModel(id: 0, name: 'name'),
      ),
    ],
  );

  test('should be a subclass of Product entity', () {
    expect(testProductModel, isA<Product>());
  });

  group('fromJson', () {
    test('should return valid model ProductModel from json', () {
      final jsonMap = json.decode(
        fixture('produk.json'),
      );

      final result = ProductModel.fromJson(jsonMap);
      expect(result, testProductModel);
    });
  });
}
