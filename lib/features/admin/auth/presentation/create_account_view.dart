import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  static const String route = 'create_Account';

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
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
              'Create Account',
              fontSize: kGlobalPadding,
              fontWeight: w600,
            ),
            vSpace(kXtremeLarge),
            TextFieldWidget(
              title: fullName,
              validator: (v) => v?.validateAnyField(field: fullName),
              hintText: fullNamePlaceholder,
              keyboardType: TextInputType.name,
              onSaved: (v) => context.auth.updateAuthData('full_name', v),
            ),
            vSpace(kMinute),
            TextFieldWidget(
              title: emailAddress,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v?.validateEmail(),
              onSaved: (v) => context.auth.updateAuthData('email', v),
              hintText: emailPlaceholder,
            ),
            vSpace(kMinute),
            TextFieldWidget(
              keyboardType: TextInputType.phone,
              hintText: numberPlaceHolder,
              validator: (v) => v?.validatePhoneNumber(),
              onSaved: (v) => context.auth.updateAuthData('phone_number', v),
              title: phoneNumber,
            ),
            vSpace(kMinute),
            TextFieldWidget(
              keyboardType: TextInputType.visiblePassword,
              hintText: passwordPlaceholder,
              validator: (v) => v?.validatePassword(),
              onSaved: (v) => context.auth.updateAuthData('password', v),
              title: password,
            ),
            verticalGap(screenHeight * .1),
            Button(
              onTap: _submit,
              text: continueWord,
            ),
            vSpace(kfsMedium),
            Center(
              child: RichTextWidget(
                text: alreadyHaveAnAccount,
                text2: logIn,
                isDMSans: true,
                onTap: TapGestureRecognizer()
                  ..onTap = () => goTo(LogInView.route),
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

      context.auth.signUp();
    }
  }
}
