import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class MemberNotifier extends ChangeNotifier {
  final CheckIDValidityUsecase _checkIDValidityUsecase;
  final GetMemberDetailsUsecase _getMemberDetailsUsecase;
  final GetAllFellowshipMembersUsecase _getAllFellowshipMembersUsecase;

  final BuildContext _context = navigatorKey.currentState!.context;

  MemberNotifier({
    required checkIDValidityUsecase,
    required getMemberDetailsUsecase,
    required getAllFellowshipMembersUsecase,
  })  : _checkIDValidityUsecase = checkIDValidityUsecase,
        _getMemberDetailsUsecase = getMemberDetailsUsecase,
        _getAllFellowshipMembersUsecase = getAllFellowshipMembersUsecase;

  Map<String, String> _memberData = {
    'admin_id': '',
    'unique_id': '',
  };

  void resetMemberData() {
    _memberData = {
      'admin_id': '',
      'unique_id': '',
    };
    notifyListeners();
  }

  String get currentMemberId => _memberData['unique_id']!;

  void updateMemberData(var key, var value) {
    if (_memberData.containsKey(key)) {
      _memberData.update(key, (_) => value);
    } else {
      _memberData.putIfAbsent(key, () => value);
    }
    notifyListeners();
  }

  void checkValidityOfId() async {
    LoadingWidget.show(_context);

    final ValidateMembersParams params = ValidateMembersParams(
      adminId: _memberData['admin_id']!,
      uniqueId: _memberData['unique_id']!,
    );

    final res = await _checkIDValidityUsecase.call(params);
    res.fold(
      (l) {
        goBack();
        Toast.showErrorToast(
          message: l.message,
        );
      },
      (r) {
        goBack();

        clearRoad(MemberHome.route);

        AppLogger.log('Is ID valid: ${r.data}');
        Toast.showSuccessToast(message: r.message);
      },
    );
  }

  AddMemberParams? member;

  void getMemberDetails() async {
    LoadingWidget.show(_context);

    final ValidateMembersParams params = ValidateMembersParams(
      adminId: _memberData['admin_id']!,
      uniqueId: _memberData['unique_id']!,
    );

    final res = await _getMemberDetailsUsecase.call(params);
    res.fold(
      (l) {
        goBack();
        AppLogger.log(l.message);
      },
      (r) {
        goBack();
        member = r.data;
        AppLogger.log(r.data);
        notifyListeners();
      },
    );
  }

  final List<AddMemberParams> _members = [];

  void getAllMembers() async {
    final res = await _getAllFellowshipMembersUsecase.call(
      _memberData['admin_id']!,
    );
    res.fold(
      (l) {
        goBack();
      },
      (r) {
        goBack();

        AppLogger.log(r.data);
        _members.addAll(r.data);
        notifyListeners();
      },
    );
  }

  String? _searchQuery;
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<AddMemberParams> get filteredMembers {
    List<AddMemberParams> filteredMembers = [];
    if (_searchQuery?.isEmpty ?? true) {
      return _members;
    }

    filteredMembers = _members.where(
      (AddMemberParams member) {
        return member.name.toLowerCase().contains(
              _searchQuery!.toLowerCase(),
            );
      },
    ).toList();
    return filteredMembers;
  }
}
