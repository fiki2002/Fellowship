import 'dart:async';

import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const String route = '/';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _slideDownAnimation;
  late Animation<double> _fadeRingInAnimation;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      bg: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AnimateBuilder(
              animation1: _slideDownAnimation,
              animation2: _fadeRingInAnimation,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(sr(kfsMedium)),
                child: Image.asset(
                  fellowshipImage,
                  height: h(kfs100),
                  width: w(kfs100),
                ),
              ),
            ),
          ],
        ),
      ),
      useSingleScroll: false,
    );
  }

  /// Determines the time spent on splash screen
  void timerForSplashScreen() {
    Timer(
      duration4s,
      () {
        final isLoggedIn = context.auth.isLoggedIn;
        if (isLoggedIn) {
          clearRoad(HomeView.route);
        } else {
          clearRoad(OnboardingView.route);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    timerForSplashScreen();

    _controller = AnimationController(
      vsync: this,
      duration: duration4s,
    );

    animateRing();

    context.auth.checkLoginStatus();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animateRing() {
    _slideDownAnimation = Tween<double>(begin: -1000, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.fastEaseInToSlowEaseOut,
        ),
      ),
    );

    _fadeRingInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );
  }
}

class _AnimateBuilder extends StatelessWidget {
  const _AnimateBuilder({
    required this.animation1,
    required this.animation2,
    required this.child,
  });

  final Animation<double> animation1, animation2;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation1,
      child: child,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation1.value),
          child: Opacity(
            opacity: animation2.value,
            child: child!,
          ),
        );
      },
    );
  }
}
