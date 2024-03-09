import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  static const String route = 'login';

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              welcomeBack,
              fontSize: kGlobalPadding,
              fontWeight: w600,
            ),
            vSpace(kXtremeLarge),
            TextFieldWidget(
              title: emailAddress,
              hintText: emailPlaceholder,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v?.validateEmail(),
              onSaved: (v) => context.auth.updateAuthData('email', v),
            ),
            vSpace(kMinute),
            TextFieldWidget(
              hintText: passwordPlaceholder,
              title: password,
              keyboardType: TextInputType.visiblePassword,
              validator: (v) => v?.validatePassword(),
              onSaved: (v) => context.auth.updateAuthData('password', v),
            ),
            verticalGap(screenHeight * .1),
            Button(
              onTap: _submit,
              text: continueWord,
            ),
            vSpace(kfsMedium),
            Center(
              child: RichTextWidget(
                text: doNotHaveAnAccount,
                text2: signUp,
                isDMSans: true,
                onTap: TapGestureRecognizer()
                  ..onTap = () => goTo(CreateAccountView.route),
                fontWeight2: w500,
                textColor2: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
      useSingleScroll: true,
    );
  }

  void _submit() {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();

      context.auth.signIn();
    }
  }
}
