import 'dart:async';

import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class CheckUserLoginStatusUsecase
    implements UseCaseFuture<Failure, bool, NoParams> {
  final AuthRepository _authenticationRepository;

  CheckUserLoginStatusUsecase(
      {required AuthRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await _authenticationRepository.isUserLoggedIn();
  }
}
