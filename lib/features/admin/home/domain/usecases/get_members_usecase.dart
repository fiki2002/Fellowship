import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class GetMembersUsecase
    implements UseCaseFuture<Failure, BaseEntity, NoParams> {
  final HomeRepository _homeRepo;

  const GetMembersUsecase({
    required HomeRepository homeRepository,
  }) : _homeRepo = homeRepository;

  @override
  Future<Either<Failure, BaseEntity>> call(NoParams params) async {
    return await _homeRepo.getMembers();
  }
}
