class SignUpParamsModel {
  final String fullName;
  final String password;
  final String email;
  final String phoneNumber;

  SignUpParamsModel({
    required this.phoneNumber,
    required this.fullName,
    required this.password,
    required this.email,
  });

  @override
  String toString() {
    return 'SignUpParamsModel(fullName: $fullName, password: $password, email: $email, phoneNumber: $phoneNumber)';
  }
}
