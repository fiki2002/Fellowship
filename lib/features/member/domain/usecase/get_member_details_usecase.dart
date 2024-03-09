import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class GetMemberDetailsUsecase
    implements UseCaseFuture<Failure, BaseModel, ValidateMembersParams> {
  final MemberRepository _memberRepo;

  const GetMemberDetailsUsecase({
    required MemberRepository memberRepository,
  }) : _memberRepo = memberRepository;

  @override
  Future<Either<Failure, BaseModel>> call(
    ValidateMembersParams params,
  ) async {
    return await _memberRepo.getMemberDetails(params);
  }
}
