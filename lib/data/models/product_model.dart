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

  Map<String, dynamic> toJson() => {'data': product};
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
        createDate: json['updated_at'] ?? "null",
        productCategory: json['category'] != null
            ? ProductCategoryModel.fromJson(
                json['category'],
              )
            : const ProductCategoryModel(id: 0, name: 'null'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'category_id': categoryId,
        'harga': harga,
        'deskripsi': deskripsi,
        'storck': stock,
        'updated_at': createDate,
        'category': productCategory
      };
}

class ProductCategoryModel extends ProductCategory {
  const ProductCategoryModel({required super.id, required super.name});

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(id: json['id'] ?? 0, name: json['name'] ?? "null");

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
