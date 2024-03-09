import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class HomeNotifier extends ChangeNotifier {
  final AddMemberUsecase _addMemberUsecase;
  final GetMembersUsecase _getMembersUsecase;
  final GetUserUsecase _getUserUsecase;

  HomeNotifier({
    required AddMemberUsecase addMemberUsecase,
    required GetMembersUsecase getMembersUsecase,
    required GetUserUsecase getUserUsecase,
    required LogOutUsecase logOutUsecase,
  })  : _addMemberUsecase = addMemberUsecase,
        _getMembersUsecase = getMembersUsecase,
        _getUserUsecase = getUserUsecase;

  final BuildContext _context = navigatorKey.currentState!.context;

  Map<String, String> _addMemberData = {
    'email': '',
    'full_name': '',
    'phone_number': '',
  };

  void resetAddMemberData() {
    _addMemberData = {
      'email': '',
      'full_name': '',
      'phone_number': '',
    };
    notifyListeners();
  }

  void updateAddMemberData(var key, var value) {
    if (_addMemberData.containsKey(key)) {
      _addMemberData.update(key, (_) => value);
    } else {
      _addMemberData.putIfAbsent(key, () => value);
    }
    notifyListeners();
  }

  void addMember() async {
    if (!validateGender()) {
      Toast.showWarningToast(message: 'Gender of the member is required!');
      return;
    }

    LoadingWidget.show(_context);

    final AddMemberParams body = AddMemberParams(
      name: _addMemberData['full_name'] ?? '',
      phoneNumber: _addMemberData['phone_number'] ?? '',
      address: _addMemberData['address'] ?? '',
      gender: maleSelected ? 'male' : 'female',
    );

    AppLogger.log('BODY:  $body');

    final response = await _addMemberUsecase.call(body);

    response.fold(
      (l) {
        goBack();

        goBack();
        Toast.showErrorToast(message: l.message);
      },
      (r) {
        goBack();

        goBack();
        Toast.showSuccessToast(message: r.message);
        refresh();
      },
    );
  }

  void refresh() {
    _members.clear();
    notifyListeners();
    getMembers();
  }

  final List<AddMemberParams> _members = [];

  void getMembers() async {
    LoadingWidget.show(_context);
    final response = await _getMembersUsecase.call(const NoParams());
    response.fold(
      (l) {
        goBack();

        Toast.showErrorToast(message: l.message);
      },
      (r) {
        goBack();
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

  UserEntity? user;

  void getUser() async {
    final response = await _getUserUsecase.call(const NoParams());

    response.fold(
      (l) {},
      (r) {
        user = r;
        notifyListeners();
      },
    );
  }

  bool femaleSelected = false;
  bool maleSelected = false;

  void onMaleCheckChanged(bool? value) {
    maleSelected = value ?? false;
    femaleSelected = !maleSelected;
    notifyListeners();
  }

  void onFemaleCheckChanged(bool? value) {
    femaleSelected = value ?? false;
    maleSelected = !femaleSelected;
    notifyListeners();
  }

  bool validateGender() {
    return maleSelected || femaleSelected;
  }
}
