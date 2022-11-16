import 'package:flutter_ecommerce/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({required super.product});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        product: json['data'] != null
            ? (json['data'] as List)
                .map(
                  (e) => ProductDetailModel.fromJson(e),
                )
                .toList()
            : [],
      );
}

class ProductDetailModel extends ProductDetail {
  const ProductDetailModel(
      {required super.id,
      required super.name,
      required super.categoryId,
      required super.image,
      required super.harga,
      required super.deskripsi,
      required super.stock,
      required super.createDate,
      required super.productCategory});

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "null",
        categoryId: json['category_id'] ?? 0,
        image: json['image'] ?? "null",
        harga: json['harga'] ?? 0,
        deskripsi: json['deskripsi'] ?? "null",
        stock: json['stock'] ?? 0,
        createDate: json['created_at'] ?? "null",
        productCategory: json['category'] != null
            ? ProductCategoryModel.fromJson(
                json['category'],
              )
            : const ProductCategoryModel(id: 0, name: 'null'),
      );
}

class ProductCategoryModel extends ProductCategory {
  const ProductCategoryModel({required super.id, required super.name});

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(id: json['id'] ?? 0, name: json['name'] ?? "null");
}
