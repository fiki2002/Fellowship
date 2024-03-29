import 'package:fellowship/features/features.dart';
import 'package:get_it/get_it.dart';

class SetUpLocators {
  static const SetUpLocators _instance = SetUpLocators._();
  const SetUpLocators._();

  factory SetUpLocators() => _instance;

  static final getIt = GetIt.instance;

  static void init() {
    //! ****** Auth Locator ****** !//
    setUpAuthLocator();

    adminLocator();

    memberLocator();
  }
}
