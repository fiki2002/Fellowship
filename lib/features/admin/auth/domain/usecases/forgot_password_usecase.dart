import 'dart:async';

import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class ForgotPasswordUsecase implements UseCaseVoid<Failure, String> {
  final AuthRepository _authenticationRepository;

  const ForgotPasswordUsecase({
    required AuthRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  @override
  FutureOr<Either<Failure, void>> call(String params) async {
    return await _authenticationRepository.forgotPassword(params);
  }
}
