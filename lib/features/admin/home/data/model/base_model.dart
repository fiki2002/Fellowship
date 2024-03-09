import 'package:fellowship/features/features.dart';

class BaseModel extends BaseEntity {
  const BaseModel({
    required super.success,
    required super.message,
    super.data,
  });
}
