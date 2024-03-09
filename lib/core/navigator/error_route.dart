import 'package:fellowship/core/core.dart';

Route<dynamic> errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return ScaffoldWidget(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          title: const TextWidget('Page Not Found'),
        ),
        body: const Center(
          child: TextWidget('ERROR! Page not found'),
        ),
        useSingleScroll: false,
      );
    },
  );
}
