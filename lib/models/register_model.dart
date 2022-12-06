class RegisterModel {
  final String name;
  final String email;
  final String handphone;
  final String password;
  final String passwordConfirmation;

  RegisterModel(
      {required this.name,
      required this.email,
      required this.handphone,
      required this.password,
      required this.passwordConfirmation});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'handphone': handphone,
        'password': password,
        'password_confirmation': passwordConfirmation
      };
}
