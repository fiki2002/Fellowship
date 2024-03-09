import 'package:fellowship/core/core.dart';
import 'package:provider/provider.dart';

class FellowshipApp extends StatelessWidget {
  const FellowshipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, Widget? child) {
        return MultiProvider(
          providers: providers,
          child: MaterialApp(
            title: 'Fellowship',
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            theme: ThemeData(
              scaffoldBackgroundColor: kWhiteColor,
            ),
            onGenerateRoute: RouteGenerator.generateRoute,
            navigatorKey: navigatorKey,
          ),
        );
      },
    );
  }
}
