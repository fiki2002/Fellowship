import 'dart:async';

import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class LogOutUsecase implements UseCaseVoid<Failure, NoParams> {
  final AuthRepository _authenticationRepository;

  const LogOutUsecase({required AuthRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  FutureOr<Either<Failure, void>> call(NoParams params) async {
    return await _authenticationRepository.logout();
  }
}
