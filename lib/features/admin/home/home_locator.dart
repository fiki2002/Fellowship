import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

void adminLocator() {
  /// Data source
  getIt.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(
      firebaseHelper: FirebaseHelper(),
    ),
  );

  /// Repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepoImpl(
      homeDataSource: getIt<HomeDataSource>(),
    ),
  );

  ///Usecases
  getIt.registerLazySingleton<AddMemberUsecase>(
    () => AddMemberUsecase(
      homeRepository: getIt<HomeRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetMembersUsecase>(
    () => GetMembersUsecase(
      homeRepository: getIt<HomeRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetUserUsecase>(
    () => GetUserUsecase(
      homeRepository: getIt<HomeRepository>(),
    ),
  );

  ///Notifier
  getIt.registerLazySingleton<HomeNotifier>(
    () => HomeNotifier(
      addMemberUsecase: getIt<AddMemberUsecase>(),
      getMembersUsecase: getIt<GetMembersUsecase>(),
      getUserUsecase: getIt<GetUserUsecase>(),
      logOutUsecase: getIt<LogOutUsecase>(),
    ),
  );
}
