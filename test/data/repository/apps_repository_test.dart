import 'dart:convert';

import 'package:flutter_ecommerce/config/config.dart';
import 'package:flutter_ecommerce/data/repository/apps_repository.dart';
import 'package:flutter_ecommerce/models/cart_model.dart';
import 'package:flutter_ecommerce/models/login_model.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/models/register_model.dart';
import 'package:flutter_ecommerce/models/review_model.dart';
import 'package:flutter_ecommerce/models/transaction_model.dart';
import 'package:flutter_ecommerce/models/wishlist_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../fixtures/fixture_reader.dart';
import 'apps_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>(as: #MockHttpClient)])
@GenerateMocks([AppsRepository])
void main() {
  MockAppsRepository mockAppsRepository = MockAppsRepository();
  MockHttpClient mockHttp = MockHttpClient();

  group('Login', () {
    LoginModel testLoginModel =
        LoginModel(email: 'email', password: 'password');
    test('Should get response statusCode 200', () async {
      when(
        mockHttp.post(any, body: testLoginModel.toJson()),
      ).thenAnswer((_) async => http.Response(fixture('login.json'), 200));

      final result = await mockHttp.post(Uri.parse("$baseUrl/api/login"),
          body: testLoginModel.toJson());

      expect(result.statusCode == 200, true);
    });
  });

  group('Register', () {
    RegisterModel testRegisterModel = RegisterModel(
        name: 'name',
        email: 'email',
        handphone: 'handphone',
        password: 'password',
        passwordConfirmation: 'passwordConfirmation');
    test('Should get response statusCode 200', () async {
      when(
        mockHttp.post(any, body: testRegisterModel.toJson()),
      ).thenAnswer((_) async => http.Response(fixture('register.json'), 200));

      final result = await mockHttp.post(Uri.parse("$baseUrl/api/register"),
          body: testRegisterModel.toJson());

      expect(result.statusCode == 200, true);
    });
  });

  group('Product', () {
    final ProductModel testProductModel =
        ProductModel.fromJson(json.decode(fixture('product.json')));
    test('Should return valid List of ProductDetailModel', () async {
      when(mockAppsRepository.fetchProduct())
          .thenAnswer((_) async => testProductModel.product);

      final result = await mockAppsRepository.fetchProduct();

      expect(result.first.name, equals(testProductModel.product.first.name));
    });
  });

  group('Wishlist', () {
    final List<WishListModel> testWishlistModel =
        (json.decode(fixture('wishlist.json'))['data'] as List)
            .map((e) => WishListModel.fromJson(e))
            .toList();
    test('Should return valid List of ProductDetailModel', () async {
      when(mockAppsRepository.fetchWishlistProduct())
          .thenAnswer((_) async => testWishlistModel);

      final result = await mockAppsRepository.fetchWishlistProduct();

      expect(result.first.id, equals(testWishlistModel.first.id));
    });
  });

  group('Cart', () {
    final List<CartModel> testCartModel =
        (json.decode(fixture('cart.json'))['data'] as List)
            .map((e) => CartModel.fromJson(e))
            .toList();
    test('Should return valid List of CartModel', () async {
      when(mockAppsRepository.fetchCart())
          .thenAnswer((_) async => testCartModel);

      final result = await mockAppsRepository.fetchCart();

      expect(result.first.id, equals(testCartModel.first.id));
    });
  });

  group('Transaction', () {
    final List<TransactionModel> testTransactionModel =
        (json.decode(fixture('transaction.json'))['data'] as List)
            .map((e) => TransactionModel.fromJson(e))
            .toList();
    test('Should return valid List of TransactionModel', () async {
      when(mockAppsRepository.fetchTransaction())
          .thenAnswer((_) async => testTransactionModel);

      final result = await mockAppsRepository.fetchTransaction();

      expect(result.first.id, equals(testTransactionModel.first.id));
    });
  });
  group('Review', () {
    final List<ReviewModel> testReviewModel =
        (json.decode(fixture('review.json'))['data'] as List)
            .map((e) => ReviewModel.fromJson(e))
            .toList();
    test('Should return valid List of ReviewModel', () async {
      when(mockAppsRepository.fetchReview(productId: 0))
          .thenAnswer((_) async => testReviewModel);

      final result = await mockAppsRepository.fetchReview(productId: 0);

      expect(result.first.id, equals(testReviewModel.first.id));
    });
  });
}
