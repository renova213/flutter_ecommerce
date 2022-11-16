import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final List<ProductDetail> product;

  const Product({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductDetail extends Equatable {
  final int id;
  final String name;
  final int categoryId;
  final String image;
  final int harga;
  final String deskripsi;
  final int stock;
  final String createDate;
  final ProductCategory productCategory;

  const ProductDetail(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.image,
      required this.harga,
      required this.deskripsi,
      required this.stock,
      required this.createDate,
      required this.productCategory});

  @override
  List<Object> get props => [
        id,
        name,
        categoryId,
        image,
        harga,
        deskripsi,
        stock,
        createDate,
        productCategory
      ];
}

class ProductCategory extends Equatable {
  final int id;
  final String name;

  const ProductCategory({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}
