import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final GetIt getIt = SetUpLocators.getIt;

List<SingleChildWidget> _providers = [
  ChangeNotifierProvider(
    create: (_) => getIt<AuthNotifier>(),
  ),
  ChangeNotifierProvider(
    create: (_) => getIt<HomeNotifier>(),
  ),
  ChangeNotifierProvider(
    create: (_) => getIt<MemberNotifier>(),
  ),
];

List<SingleChildWidget> get providers => _providers;
