import 'dart:convert';

import 'package:flutter_ecommerce/models/review_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  ReviewModel testReviewModel = ReviewModel(
      id: 0,
      productId: 0,
      user: ReviewUserModel(
          id: 0, email: 'email', name: 'name', handphone: 'handphone'),
      userId: 0,
      review: 'review',
      image: 'image',
      createdAt: 'created_at',
      star: 0);

  group('fromJson', () {
    test('should return valid model ReviewModel from json', () {
      final jsonMap = json.decode(
        fixture('review.json'),
      );

      final result = (jsonMap['data'] as List)
          .map((e) => ReviewModel.fromJson(e))
          .toList();

      expect(result.first.id, equals(testReviewModel.id));
    });
  });
}
