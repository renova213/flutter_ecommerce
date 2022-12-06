class WishListModel {
  final int id;
  final int productId;
  final int userId;
  final WishListProduct product;

  WishListModel(
      {required this.id,
      required this.product,
      required this.userId,
      required this.productId});

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
      id: json['id'],
      product: WishListProduct.fromJson(json['product']),
      userId: json['user_id'],
      productId: json['product_id']);
}

class WishListProduct {
  final int id;
  final String name;
  final int categoryId;
  final String image;
  final int harga;
  final String deskripsi;
  final int stock;
  final String createDate;

  WishListProduct(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.image,
      required this.harga,
      required this.deskripsi,
      required this.stock,
      required this.createDate});

  factory WishListProduct.fromJson(Map<String, dynamic> json) =>
      WishListProduct(
        id: json['id'] ?? 0,
        name: json['name'] ?? "null",
        categoryId: json['category_id'] ?? 0,
        image: json['image'] ?? "null",
        harga: json['harga'] ?? 0,
        deskripsi: json['deskripsi'] ?? "null",
        stock: json['stock'] ?? 0,
        createDate: json['updated_at'] ?? "null",
      );
}
