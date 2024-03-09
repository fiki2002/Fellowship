import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  static const String route = 'onboarding';

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            welcome,
            fontSize: kGlobalPadding,
            fontWeight: w600,
          ),
          verticalGap(screenHeight * .1),
          Button.withBorderLine(
            onTap: () => goTo(LogInView.route),
            text: admin,
          ),
          vSpace(kMinute),
          Button.withBorderLine(
            onTap: () => goTo(MemberView.route),
            text: member,
          ),
        ],
      ),
      useSingleScroll: true,
    );
  }
}
