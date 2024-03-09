class AddMemberParams {
  final String name;
  final String phoneNumber;
  final String address;
  final String gender;
  final bool isCurrentMember;

  AddMemberParams({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.gender,
    this.isCurrentMember = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone_number": phoneNumber,
      "address": address,
      "gender": gender
    };
  }

  factory AddMemberParams.fromJson(Map<String, dynamic> json) {
    return AddMemberParams(
      address: json['address'],
      gender: json['gender'],
      name: json['name'],
      phoneNumber: json['phone_number'],
    );
  }

  @override
  String toString() {
    return 'AddMemberParams(name: $name, phoneNumber: $phoneNumber, address: $address, gender: $gender)';
  }

  AddMemberParams copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    String? gender,
    bool? isCurrentMember,
  }) {
    return AddMemberParams(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      isCurrentMember: isCurrentMember ?? this.isCurrentMember,
    );
  }
}
