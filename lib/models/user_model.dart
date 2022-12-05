class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  String? alamat;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      this.alamat});
}
