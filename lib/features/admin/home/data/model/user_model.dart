import 'package:fellowship/features/features.dart';

class UserModel extends UserEntity {
  UserModel({
    super.email,
    super.fullName,
    super.phoneNumber,
    super.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      userId: json['user_id'],
    );
  }
}
