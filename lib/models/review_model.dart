class ReviewModel {
  final int id;
  final int productId;
  final int userId;
  final int star;
  final String review;
  final String image;
  final String createdAt;
  final ReviewUserModel user;

  ReviewModel(
      {required this.id,
      required this.productId,
      required this.user,
      required this.userId,
      required this.review,
      required this.image,
      required this.createdAt,
      required this.star});

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json['id'],
        productId: json['product_id'],
        userId: json['user_id'],
        review: json['review'],
        image: json['image'],
        createdAt: json['created_at'],
        star: json['star'],
        user: ReviewUserModel.fromJson(json['user']),
      );
}

class ReviewUserModel {
  final int id;
  final String email;
  final String name;
  final String handphone;

  ReviewUserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.handphone});

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) =>
      ReviewUserModel(
          id: json['id'],
          email: json['email'],
          name: json['name'],
          handphone: json['handphone']);
}
