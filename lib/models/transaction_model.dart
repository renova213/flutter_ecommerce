class TransactionModel {
  final int id;
  final int total;
  final String status;
  final String alamat;
  final int userId;
  final String createdAt;
  final List<TransactionProductModel> transactionProduct;

  TransactionModel(
      {required this.id,
      required this.total,
      required this.status,
      required this.alamat,
      required this.userId,
      required this.createdAt,
      required this.transactionProduct});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        total: json['total'],
        status: json['status'],
        alamat: json['alamat'],
        userId: json['user_id'],
        createdAt: json['created_at'],
        transactionProduct: (json['products'] as List)
            .map(
              (e) => TransactionProductModel.fromJson(e),
            )
            .toList(),
      );
}

class TransactionProductModel {
  final int id;
  final String name;
  final int categoryId;
  final String image;
  final int harga;
  final String description;
  final int stock;
  final String createdAt;
  final PivotTransactionModel pivotTransaction;

  TransactionProductModel(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.image,
      required this.harga,
      required this.description,
      required this.createdAt,
      required this.stock,
      required this.pivotTransaction});

  factory TransactionProductModel.fromJson(Map<String, dynamic> json) =>
      TransactionProductModel(
        id: json['id'],
        name: json['name'],
        categoryId: json['category_id'],
        image: json['image'],
        harga: json['harga'],
        description: json['deskripsi'],
        createdAt: json['created_at'],
        stock: json['stock'],
        pivotTransaction: PivotTransactionModel.fromJson(json['pivot']),
      );
}

class PivotTransactionModel {
  final int transactionId;
  final int productId;
  final int quantity;

  PivotTransactionModel(
      {required this.productId,
      required this.quantity,
      required this.transactionId});

  factory PivotTransactionModel.fromJson(Map<String, dynamic> json) =>
      PivotTransactionModel(
          productId: json['transaction_id'],
          quantity: json['qty'],
          transactionId: json['product_id']);
}
