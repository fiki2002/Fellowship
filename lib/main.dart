import 'package:fellowship/core/core.dart';
import 'package:fellowship/core/utils/setup.dart';

Future<void> main() async {
  await Setup.run();
  runApp(
    const FellowshipApp(),
  );
}
