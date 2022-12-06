class ProductModel {
  final List<ProductDetailModel> product;

  ProductModel({required this.product});

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

class ProductDetailModel {
  final int id;
  final String name;
  final int categoryId;
  final String image;
  final int harga;
  final String deskripsi;
  final int stock;
  final String createDate;
  final ProductCategoryModel productCategory;

  ProductDetailModel(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.image,
      required this.harga,
      required this.deskripsi,
      required this.stock,
      required this.createDate,
      required this.productCategory});

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
            : ProductCategoryModel(id: 0, name: 'null'),
      );
}

class ProductCategoryModel {
  final int id;
  final String name;

  ProductCategoryModel({required this.id, required this.name});

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(id: json['id'] ?? 0, name: json['name'] ?? "null");
}
