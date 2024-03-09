import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class GetUserUsecase implements UseCaseFuture<Failure, UserEntity, NoParams> {
  final HomeRepository _homeRepo;

  const GetUserUsecase({
    required HomeRepository homeRepository,
  }) : _homeRepo = homeRepository;

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await _homeRepo.getUser();
  }
}
