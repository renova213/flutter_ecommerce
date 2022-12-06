class CartModel {
  final int id;
  final int userId;
  final int productId;
  final int quantity;
  final CartProduct cartProduct;

  CartModel(
      {required this.id,
      required this.cartProduct,
      required this.productId,
      required this.quantity,
      required this.userId});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json['id'],
      cartProduct: CartProduct.fromJson(json['product']),
      productId: json['product_id'],
      quantity: json['qty'],
      userId: json['user_id']);
}

class CartProduct {
  final int id;
  final String name;
  final int categoryId;
  final String image;
  final int harga;
  final String deskripsi;
  final int stock;

  CartProduct(
      {required this.id,
      required this.categoryId,
      required this.deskripsi,
      required this.harga,
      required this.image,
      required this.name,
      required this.stock});

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json['id'] ?? 0,
        name: json['name'] ?? "null",
        categoryId: json['category_id'] ?? 0,
        image: json['image'] ?? "null",
        harga: json['harga'] ?? 0,
        deskripsi: json['deskripsi'] ?? "null",
        stock: json['stock'] ?? 0,
      );
}
