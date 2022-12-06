import 'dart:convert';

import 'package:flutter_ecommerce/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  TransactionModel testTransactionModel = TransactionModel(
    id: 0,
    total: 0,
    status: 'status',
    alamat: 'alamat',
    userId: 0,
    createdAt: 'created_at',
    transactionProduct: [
      TransactionProductModel(
        id: 0,
        name: 'name',
        categoryId: 0,
        image: 'image',
        harga: 0,
        description: 'description',
        createdAt: 'created_at',
        stock: 0,
        pivotTransaction:
            PivotTransactionModel(productId: 0, quantity: 0, transactionId: 0),
      ),
    ],
  );

  group('fromJson', () {
    test('should return valid model TrasactionModel from json', () {
      final jsonMap = json.decode(
        fixture('transaction.json'),
      );

      final result = (jsonMap['data'] as List)
          .map((e) => TransactionModel.fromJson(e))
          .toList();

      expect(
        result.first.id,
        equals(testTransactionModel.id),
      );
    });
  });
}
