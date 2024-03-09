import 'dart:async';

import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class MemberRepoImpl extends MemberRepository with BaseRepoImpl {
  final MemberDataSource _memberDataSource;
  MemberRepoImpl({
    required MemberDataSource memberDataSource,
  }) : _memberDataSource = memberDataSource;

  @override
  FutureOr<Either<Failure, BaseModel>> isUniqueIdValid(
    ValidateMembersParams params,
  ) {
    return callAction(
      () async {
        final response = await _memberDataSource.isIDValid(
          params,
        );
        return response;
      },
    );
  }

  @override
  FutureOr<Either<Failure, BaseModel>> getMemberDetails(
    ValidateMembersParams params,
  ) {
    return callAction(
      () async {
        final response = await _memberDataSource.getMember(
          params,
        );
        return response;
      },
    );
  }

  @override
  FutureOr<Either<Failure, BaseModel>> getAllMembers(String adminId) {
    return callAction(
      () async {
        final response = await _memberDataSource.getAllMembers(
          adminId,
        );
        return response;
      },
    );
  }
}
