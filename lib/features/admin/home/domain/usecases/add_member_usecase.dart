import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class AddMemberUsecase
    implements UseCaseFuture<Failure, BaseEntity, AddMemberParams> {
  final HomeRepository _homeRepo;

  const AddMemberUsecase({
    required HomeRepository homeRepository,
  }) : _homeRepo = homeRepository;

  @override
  Future<Either<Failure, BaseEntity>> call(AddMemberParams params) async {
    return await _homeRepo.addMember(params);
  }
}
