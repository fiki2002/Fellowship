import 'dart:async';

import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class SignUpUsecase
    implements UseCaseFuture<Failure, AuthResultEntity, SignUpParamsModel> {
  final AuthRepository _authenticationRepository;

  const SignUpUsecase({required AuthRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  @override
  FutureOr<Either<Failure, AuthResultEntity>> call(
    SignUpParamsModel params,
  ) async {
    return await _authenticationRepository.register(params);
  }
}
