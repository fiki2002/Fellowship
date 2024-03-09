import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeDataSource {
  Future<BaseModel> addMember(AddMemberParams params);
  Future<BaseModel> getAllMembers();
  Future<UserModel> getUser();
}

class HomeDataSourceImpl extends HomeDataSource {
  final FirebaseHelper _firebaseHelper;

  HomeDataSourceImpl({
    required FirebaseHelper firebaseHelper,
  }) : _firebaseHelper = firebaseHelper;

  @override
  Future<BaseModel> addMember(AddMemberParams params) async {
    final User? user = FirebaseAuth.instance.currentUser;

    _firebaseHelper
        .addMemberRef(adminId: user?.email ?? '')
        .doc(
          '${params.name}${params.phoneNumber.substring(params.phoneNumber.length - 2)}',
        )
        .set(
          params.toJson(),
        );

    return BaseModel(
      success: true,
      message: 'Member added successfully!',
      data: params,
    );
  }

  @override
  Future<BaseModel> getAllMembers() async {
    final User? user = FirebaseAuth.instance.currentUser;

    final snapshot =
        await _firebaseHelper.addMemberRef(adminId: user?.email ?? '').get();

    final List<AddMemberParams> members = snapshot.docs.map(
      (doc) {
        final data = doc.data();
        return AddMemberParams.fromJson(data);
      },
    ).toList();

    return BaseModel(
      success: true,
      message: 'Members retrieved successfully!',
      data: members,
    );
  }

  @override
  Future<UserModel> getUser() async {
    final User? user = FirebaseAuth.instance.currentUser;

    final DocumentSnapshot<Map<String, dynamic>> result =
        await _firebaseHelper.userCollectionRef().doc(user?.email ?? '').get();
    return UserModel.fromJson(result.data() ?? {});
  }
}
