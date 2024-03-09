import 'dart:async';

import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

abstract class MemberRepository {
  FutureOr<Either<Failure, BaseModel>> isUniqueIdValid(
    ValidateMembersParams params,
  );
  FutureOr<Either<Failure, BaseModel>> getMemberDetails(
    ValidateMembersParams params,
  );

  FutureOr<Either<Failure, BaseModel>> getAllMembers(
    String adminId,
  );
}
