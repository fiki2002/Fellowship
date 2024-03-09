import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class AuthNotifier extends ChangeNotifier {
  final LoginUsecase _logInUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  final SignUpUsecase _signUpUsecase;
  final CheckUserLoginStatusUsecase _checkUserStatusUsecase;
  final LogOutUsecase _logOutUsecase;

  AuthNotifier({
    required logInUsecase,
    required forgotPasswordUsecase,
    required signUpUsecase,
    required checkUserStatusUsecase,
    required logOutUsecase,
  })  : _logInUsecase = logInUsecase,
        _forgotPasswordUsecase = forgotPasswordUsecase,
        _signUpUsecase = signUpUsecase,
        _logOutUsecase = logOutUsecase,
        _checkUserStatusUsecase = checkUserStatusUsecase;

  final BuildContext _context = navigatorKey.currentState!.context;

  Map<String, String> _authData = {
    'email': '',
    'full_name': '',
    'phone_number': '',
    'password': '',
  };

  void resetAuthData() {
    _authData = {
      'email': '',
      'full_name': '',
      'phone_number': '',
      'password': '',
    };
    notifyListeners();
  }

  void updateAuthData(var key, var value) {
    if (_authData.containsKey(key)) {
      _authData.update(key, (_) => value);
    } else {
      _authData.putIfAbsent(key, () => value);
    }
    notifyListeners();
  }

  Future<Either<Failure, AuthResultEntity>> signUp() async {
    LoadingWidget.show(_context);

    final params = SignUpParamsModel(
      fullName: _authData['full_name'] ?? '',
      password: _authData['password'] ?? '',
      email: _authData['email'] ?? '',
      phoneNumber: _authData['phone_number'] ?? '',
    );

    AppLogger.log('Create Account params:  $params');

    final response = await _signUpUsecase.call(params);

    return response.fold(
      (Failure failure) {
        goBack();
        _handleFailure(failure);

        return Left(failure);
      },
      (AuthResultEntity res) {
        goBack();

        clearRoad(HomeView.route, );

        _handleSuccess(res, false);

        return Right(res);
      },
    );
  }

  Future<Either<Failure, AuthResultEntity>> signIn() async {
    LoadingWidget.show(_context);

    final response = await _logInUsecase.call(
      LoginDataParams(
        email: _authData['email'] ?? '',
        password: _authData['password'] ?? '',
      ),
    );

    return response.fold(
      (Failure failure) {
        goBack();
        _handleFailure(failure);

        return Left(failure);
      },
      (AuthResultEntity res) {
        goBack();

        clearRoad(HomeView.route);

        _handleSuccess(res);

        return Right(res);
      },
    );
  }

  Future<Either<Failure, void>> forgotPassword() async {
    LoadingWidget.show(_context);

    final response =
        await _forgotPasswordUsecase.call(_authData['email'] ?? '');

    return response.fold(
      (Failure failure) {
        goBack();

        _handleFailure(failure);

        return Left(failure);
      },
      (_) {
        goBack();

        return const Right(null);
      },
    );
  }

  Future<Either<Failure, void>> logOut() async {
    LoadingWidget.show(_context);
    final response = await _logOutUsecase.call(const NoParams());
    return response.fold(
      (Failure failure) {
        _handleFailure(failure);

        return Left(failure);
      },
      (_) {
        goBack();

        clearRoad(OnboardingView.route);

        Toast.showSuccessToast(
          message: 'You\'ve been logged out successfully!',
        );
        return const Right(null);
      },
    );
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  /// Check User Login Status
  Future<bool> checkLoginStatus() async {
    final res = await _checkUserStatusUsecase.call(const NoParams());
    res.fold(
      (l) => Left(l),
      (r) {
        _isLoggedIn = r;
        notifyListeners();
      },
    );
    return _isLoggedIn;
  }

  void _handleFailure(Failure failure) {
    Toast.showErrorToast(message: failure.message);
  }

  void _handleSuccess(AuthResultEntity res, [bool shouldShowToast = true]) {
    resetAuthData();
    if (shouldShowToast == true) {
      Toast.showSuccessToast(message: res.message);
    }
  }
}

enum AuthState { isLoading, isDone, isError }
