
import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

void setUpAuthLocator() {
  /// Data source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseHelper: FirebaseHelper(),
    ),
  );

  /// Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepoImpl(
      authDataSource: getIt<AuthRemoteDataSource>(),
    ),
  );

  /// Usecase
  getIt.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(
      authenticationRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      authenticationRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<LogOutUsecase>(
    () => LogOutUsecase(
      authenticationRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<ForgotPasswordUsecase>(
    () => ForgotPasswordUsecase(
      authenticationRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<CheckUserLoginStatusUsecase>(
    () => CheckUserLoginStatusUsecase(
      authenticationRepository: getIt<AuthRepository>(),
    ),
  );
  getIt.registerLazySingleton<AuthNotifier>(
    () => AuthNotifier(
      forgotPasswordUsecase: getIt<ForgotPasswordUsecase>(),
      logInUsecase: getIt<LoginUsecase>(),
      signUpUsecase: getIt<SignUpUsecase>(),
      logOutUsecase: getIt<LogOutUsecase>(),
      checkUserStatusUsecase: getIt<CheckUserLoginStatusUsecase>(),
    ),
  );
}
