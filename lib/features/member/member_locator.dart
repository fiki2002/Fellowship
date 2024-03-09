import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

void memberLocator() {
  /// Data source
  getIt.registerLazySingleton<MemberDataSource>(
    () => MemberDataSourceImpl(
      firebaseHelper: FirebaseHelper(),
    ),
  );

  /// Repository
  getIt.registerLazySingleton<MemberRepository>(
    () => MemberRepoImpl(
      memberDataSource: getIt<MemberDataSource>(),
    ),
  );

  ///Usecases
  getIt.registerLazySingleton<CheckIDValidityUsecase>(
    () => CheckIDValidityUsecase(
      memberRepository: getIt<MemberRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetMemberDetailsUsecase>(
    () => GetMemberDetailsUsecase(
      memberRepository: getIt<MemberRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetAllFellowshipMembersUsecase>(
    () => GetAllFellowshipMembersUsecase(
      memberRepository: getIt<MemberRepository>(),
    ),
  );

  ///Notifier
  getIt.registerLazySingleton<MemberNotifier>(
    () => MemberNotifier(
      checkIDValidityUsecase: getIt<CheckIDValidityUsecase>(),
      getMemberDetailsUsecase: getIt<GetMemberDetailsUsecase>(),
      getAllFellowshipMembersUsecase: getIt<GetAllFellowshipMembersUsecase>(),
    ),
  );
}
