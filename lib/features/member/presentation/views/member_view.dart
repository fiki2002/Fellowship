import 'package:fellowship/core/core.dart';

class MemberView extends StatefulWidget {
  const MemberView({super.key});

  static const String route = 'member';

  @override
  State<MemberView> createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {
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
              'Input your member ID',
              fontSize: kGlobalPadding,
              fontWeight: w600,
            ),
            verticalGap(screenHeight * .1),
            TextFieldWidget(
              hintText: 'Admin ID',
              onSaved: (v) => context.member.updateMemberData('admin_id', v),
              validator: (v) => v?.validateAnyField(field: 'Admin ID'),
            ),
            vSpace(kfsMedium),
            TextFieldWidget(
              hintText: 'Membership ID',
              onSaved: (v) => context.member.updateMemberData('unique_id', v),
              validator: (v) => v?.validateAnyField(field: 'Membership ID'),
            ),
            verticalGap(screenHeight * .3),
            Button(
              onTap: _submit,
              text: 'Get Details',
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
      context.member.checkValidityOfId();
    }
  }
}
