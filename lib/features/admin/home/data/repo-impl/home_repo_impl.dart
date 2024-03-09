import 'dart:async';

import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class HomeRepoImpl extends HomeRepository with BaseRepoImpl {
  final HomeDataSource _homeDataSource;

  HomeRepoImpl({
    required HomeDataSource homeDataSource,
  }) : _homeDataSource = homeDataSource;

  @override
  FutureOr<Either<Failure, BaseEntity>> addMember(AddMemberParams params) {
    return callAction(
      () async {
        final response = await _homeDataSource.addMember(params);
        return response;
      },
    );
  }

  @override
  FutureOr<Either<Failure, BaseEntity>> getMembers() {
    return callAction(
      () async {
        final response = await _homeDataSource.getAllMembers();
        return response;
      },
    );
  }

  @override
  FutureOr<Either<Failure, UserEntity>> getUser() {
    return callAction(
      () async {
        final response = await _homeDataSource.getUser();
        return response;
      },
    );
  }
}
