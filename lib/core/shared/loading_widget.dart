import 'package:fellowship/core/core.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  static Future<void> show(BuildContext context) {
    return showAdaptiveDialog(
      context: context,
      barrierColor: kTextColor3Shade,
      barrierDismissible: false,
      builder: (context) => const LoadingWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.waveDots(
        color: kPrimaryColor,
        size: sp(kfs50),
      ),
    );
  }
}
