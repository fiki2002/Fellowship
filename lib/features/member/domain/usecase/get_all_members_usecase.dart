import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class GetAllFellowshipMembersUsecase
    implements UseCaseFuture<Failure, BaseEntity, String> {
  final MemberRepository _memberRepo;

  const GetAllFellowshipMembersUsecase({
    required MemberRepository memberRepository,
  }) : _memberRepo = memberRepository;

  @override
  Future<Either<Failure, BaseEntity>> call(String params) async {
    return await _memberRepo.getAllMembers(params);
  }
}
