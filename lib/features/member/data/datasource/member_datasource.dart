import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

abstract class MemberDataSource {
  Future<BaseModel> isIDValid(
    ValidateMembersParams params,
  );
  Future<BaseModel> getMember(
    ValidateMembersParams params,
  );
  Future<BaseModel> getAllMembers(String adminId);
}

class MemberDataSourceImpl extends MemberDataSource {
  final FirebaseHelper _firebaseHelper;

  MemberDataSourceImpl({
    required FirebaseHelper firebaseHelper,
  }) : _firebaseHelper = firebaseHelper;

  @override
  Future<BaseModel> isIDValid(ValidateMembersParams params) async {
    final DocumentSnapshot snapshot = await _firebaseHelper
        .addMemberRef(adminId: params.adminId)
        .doc(params.uniqueId)
        .get();

    final bool result = snapshot.exists;
    if (result == false) {
      throw const BaseFailures(
        message: 'You unique ID is invalid!, please contact the Admin!',
      );
    }
    return BaseModel(
      success: true,
      message: 'Welcome, you have been validated!',
      data: result,
    );
  }

  @override
  Future<BaseModel> getMember(ValidateMembersParams params) async {
    DocumentSnapshot snapshot = await _firebaseHelper
        .addMemberRef(adminId: params.adminId)
        .doc(params.uniqueId)
        .get();
    if (!snapshot.exists) {
      throw const BaseFailures(
        message: 'You were not found on the server\nKindly contact your admin',
      );
    }
    return BaseModel(
      success: true,
      message: 'Member retrieved successfully!',
      data: AddMemberParams.fromJson(snapshot.data() as Map<String, dynamic>),
    );
  }

  @override
  Future<BaseModel> getAllMembers(String adminId) async {
    final snapshot = await _firebaseHelper.addMemberRef(adminId: adminId).get();

    final List<AddMemberParams> members = snapshot.docs.map(
      (doc) {
        final data = doc.data();
        return AddMemberParams.fromJson(data);
      },
    ).toList();

    AppLogger.log('Members from Members side:$members');

    return BaseModel(
      success: true,
      message: 'All members in your fellowship retrieved successfully!',
      data: members,
    );
  }
}
