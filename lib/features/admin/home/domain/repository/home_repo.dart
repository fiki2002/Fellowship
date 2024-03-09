import 'dart:async';

import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

abstract class HomeRepository {
  FutureOr<Either<Failure, BaseEntity>> addMember(
    AddMemberParams params,
  );
  FutureOr<Either<Failure, BaseEntity>> getMembers();
  FutureOr<Either<Failure, UserEntity>> getUser();
}
