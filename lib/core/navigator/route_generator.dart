import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';
import 'package:fellowship/features/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case '/':
        return pageRoute(const SplashView());

      case 'onboarding':
        return pageRoute(const OnboardingView());

      case CreateAccountView.route:
        return pageRoute(const CreateAccountView());

      case LogInView.route:
        return pageRoute(const LogInView());

      case HomeView.route:
        return pageRoute(
          const HomeView(),
        );

      case ViewMemberDetails.route:
        return pageRoute(
          ViewMemberDetails(
            member: args as AddMemberParams,
          ),
        );
      case MemberView.route:
        return pageRoute(
          const MemberView(),
        );
            case MemberHome.route:
        return pageRoute(
          const MemberHome(),
        );

      default:
        return errorRoute();
    }
  }

  static PageRoute pageRoute(Widget page) {
    return FadeAndSlidePageRoute(builder: (_) => page);
  }
}

class FadeAndSlidePageRoute<T> extends MaterialPageRoute<T> {
  FadeAndSlidePageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.5),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
