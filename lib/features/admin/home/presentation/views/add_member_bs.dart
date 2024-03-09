import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddMemberBS extends StatefulWidget {
  const AddMemberBS({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            sr(kGlobalPadding),
          ),
          topRight: Radius.circular(
            sr(kGlobalPadding),
          ),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => const AddMemberBS(),
    );
  }

  @override
  State<AddMemberBS> createState() => _AddMemberBSState();
}

class _AddMemberBSState extends State<AddMemberBS> {
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: w(kGlobalPadding),
        vertical: h(kfs30),
      ),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextWidget(
              addMember,
              fontWeight: w600,
              fontSize: kfsMedium,
            ),
            vSpace(kXtremeLarge),
            TextFieldWidget(
              hintText: fullName,
              title: enterName,
              keyboardType: TextInputType.name,
              onSaved: (v) => context.home.updateAddMemberData('full_name', v),
              validator: (v) => v?.validateAnyField(field: fullName),
            ),
            vSpace(kfsMedium),
            TextFieldWidget(
              hintText: phoneNumber,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
              ],
              validator: (v) => v?.validatePhoneNumber(),
              onSaved: (v) =>
                  context.home.updateAddMemberData('phone_number', v),
              title: enterPhoneNumber,
            ),
            vSpace(kfsMedium),
            TextFieldWidget(
              hintText: address,
              title: enterAddress,
              keyboardType: TextInputType.streetAddress,
              validator: (v) => v?.validateAnyField(field: address),
              onSaved: (v) => context.home.updateAddMemberData('address', v),
            ),
            vSpace(kfsMedium),
            Consumer<HomeNotifier>(
              builder: (context, viewModel, _) {
                return Row(
                  children: [
                    _Gender(
                      sex: 'Male',
                      isSelected: viewModel.maleSelected,
                      onChanged: context.home.onMaleCheckChanged,
                    ),
                    _Gender(
                      sex: 'Female',
                      isSelected: viewModel.femaleSelected,
                      onChanged: context.home.onFemaleCheckChanged,
                    ),
                  ],
                );
              },
            ),
            vSpace(kXtremeLarge),
            Button(
              onTap: _submit,
              text: addMember,
            ),
            verticalGap(screenHeight * .05),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState?.save();

      context.home.addMember();
    }
  }
}

class _Gender extends StatelessWidget {
  const _Gender({
    required this.sex,
    required this.isSelected,
    this.onChanged,
  });
  final String sex;
  final bool isSelected;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onChanged?.call(!isSelected);
        },
        child: Row(
          children: [
            Checkbox.adaptive(
              value: isSelected,
              onChanged: onChanged,
              activeColor: kPrimaryColor,
            ),
            TextWidget(
              sex,
              fontSize: kfsMedium,
              textColor: kTextColor2,
              fontWeight: w600,
            ),
          ],
        ),
      ),
    );
  }
}
