import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResultEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResultEntity>> register(
    SignUpParamsModel signUpParams,
  );

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> forgotPassword(String email);

  Future<Either<Failure, bool>> isUserLoggedIn();
}
