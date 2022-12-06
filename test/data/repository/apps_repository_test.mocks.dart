// Mocks generated by Mockito 5.3.2 from annotations
// in flutter_ecommerce/test/data/repository/apps_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:convert' as _i4;
import 'dart:io' as _i13;
import 'dart:typed_data' as _i5;

import 'package:flutter_ecommerce/data/repository/apps_repository.dart' as _i6;
import 'package:flutter_ecommerce/models/cart_model.dart' as _i11;
import 'package:flutter_ecommerce/models/login_model.dart' as _i7;
import 'package:flutter_ecommerce/models/product_model.dart' as _i9;
import 'package:flutter_ecommerce/models/register_model.dart' as _i8;
import 'package:flutter_ecommerce/models/review_model.dart' as _i12;
import 'package:flutter_ecommerce/models/transaction_model.dart' as _i14;
import 'package:flutter_ecommerce/models/wishlist_model.dart' as _i10;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_1 extends _i1.SmartFake
    implements _i2.StreamedResponse {
  _FakeStreamedResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i2.Client {
  @override
  _i3.Future<_i2.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i3.Future<_i2.Response>);
  @override
  _i3.Future<_i2.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i3.Future<_i2.Response>);
  @override
  _i3.Future<_i2.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i4.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i3.Future<_i2.Response>);
  @override
  _i3.Future<_i2.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i4.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i3.Future<_i2.Response>);
  @override
  _i3.Future<_i2.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i4.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i3.Future<_i2.Response>);
  @override
  _i3.Future<_i2.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i4.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i3.Future<_i2.Response>);
  @override
  _i3.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i3.Future<String>.value(''),
        returnValueForMissingStub: _i3.Future<String>.value(''),
      ) as _i3.Future<String>);
  @override
  _i3.Future<_i5.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i3.Future<_i5.Uint8List>.value(_i5.Uint8List(0)),
        returnValueForMissingStub:
            _i3.Future<_i5.Uint8List>.value(_i5.Uint8List(0)),
      ) as _i3.Future<_i5.Uint8List>);
  @override
  _i3.Future<_i2.StreamedResponse> send(_i2.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i3.Future<_i2.StreamedResponse>.value(_FakeStreamedResponse_1(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i2.StreamedResponse>.value(_FakeStreamedResponse_1(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i3.Future<_i2.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AppsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppsRepository extends _i1.Mock implements _i6.AppsRepository {
  MockAppsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<void> postLogin(_i7.LoginModel? login) => (super.noSuchMethod(
        Invocation.method(
          #postLogin,
          [login],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> postRegister(_i8.RegisterModel? register) =>
      (super.noSuchMethod(
        Invocation.method(
          #postRegister,
          [register],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<List<_i9.ProductDetailModel>> fetchProduct() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchProduct,
          [],
        ),
        returnValue: _i3.Future<List<_i9.ProductDetailModel>>.value(
            <_i9.ProductDetailModel>[]),
      ) as _i3.Future<List<_i9.ProductDetailModel>>);
  @override
  _i3.Future<List<_i9.ProductDetailModel>> fetchCategoryProduct(
          String? value) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchCategoryProduct,
          [value],
        ),
        returnValue: _i3.Future<List<_i9.ProductDetailModel>>.value(
            <_i9.ProductDetailModel>[]),
      ) as _i3.Future<List<_i9.ProductDetailModel>>);
  @override
  _i3.Future<List<_i9.ProductDetailModel>> filterProductByName(String? value) =>
      (super.noSuchMethod(
        Invocation.method(
          #filterProductByName,
          [value],
        ),
        returnValue: _i3.Future<List<_i9.ProductDetailModel>>.value(
            <_i9.ProductDetailModel>[]),
      ) as _i3.Future<List<_i9.ProductDetailModel>>);
  @override
  _i3.Future<List<_i10.WishListModel>> fetchWishlistProduct() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchWishlistProduct,
          [],
        ),
        returnValue:
            _i3.Future<List<_i10.WishListModel>>.value(<_i10.WishListModel>[]),
      ) as _i3.Future<List<_i10.WishListModel>>);
  @override
  _i3.Future<void> postWishlist(int? idBarang) => (super.noSuchMethod(
        Invocation.method(
          #postWishlist,
          [idBarang],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> deleteWishlist(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteWishlist,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> deleteReview(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteReview,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<List<_i11.CartModel>> fetchCart() => (super.noSuchMethod(
        Invocation.method(
          #fetchCart,
          [],
        ),
        returnValue: _i3.Future<List<_i11.CartModel>>.value(<_i11.CartModel>[]),
      ) as _i3.Future<List<_i11.CartModel>>);
  @override
  _i3.Future<void> postCart({
    required int? productId,
    required int? quantity,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #postCart,
          [],
          {
            #productId: productId,
            #quantity: quantity,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> deleteCart(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteCart,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> postTransaction(String? address) => (super.noSuchMethod(
        Invocation.method(
          #postTransaction,
          [address],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<List<_i12.ReviewModel>> fetchReview({required int? productId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchReview,
          [],
          {#productId: productId},
        ),
        returnValue:
            _i3.Future<List<_i12.ReviewModel>>.value(<_i12.ReviewModel>[]),
      ) as _i3.Future<List<_i12.ReviewModel>>);
  @override
  _i3.Future<void> postReview({
    required int? productId,
    required String? review,
    required _i13.File? image,
    required String? star,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #postReview,
          [],
          {
            #productId: productId,
            #review: review,
            #image: image,
            #star: star,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<List<_i14.TransactionModel>> fetchTransaction() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchTransaction,
          [],
        ),
        returnValue: _i3.Future<List<_i14.TransactionModel>>.value(
            <_i14.TransactionModel>[]),
      ) as _i3.Future<List<_i14.TransactionModel>>);
}