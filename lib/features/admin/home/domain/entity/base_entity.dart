class BaseEntity {
  final bool success;
  final String message;
  final dynamic data;
  const BaseEntity({
    required this.success,
    required this.message,
    required this.data,
  });
}
