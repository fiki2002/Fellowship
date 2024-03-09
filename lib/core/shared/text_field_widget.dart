import 'package:fellowship/core/core.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.title,
    required this.hintText,
    this.hintTextFontSize,
    this.hintTextColor,
    this.maxLines,
    this.borderColor,
    this.prefix,
    this.readOnly = false,
    this.suffix,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
  });

  final String? title;
  final String hintText;
  final Color? hintTextColor;
  final void Function(String?)? onSaved;
  final double? hintTextFontSize;
  final int? maxLines;
  final Color? borderColor;
  final Widget? prefix;
  final Widget? suffix;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          TextWidget(
            title!,
            isDMSans: true,
            fontSize: kfsVeryTiny,
            textColor: kTextColor1,
          ),
          vSpace(kfsVeryTiny),
        ],
        TextFormField(
          cursorColor: borderColor ?? kSecondaryColor,
          style: const TextStyle(),
          autocorrect: false,
          readOnly: readOnly,
          onChanged: onChanged,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          onSaved: onSaved,
          decoration: InputDecoration(
            suffixIcon: suffix,
            prefixIcon: prefix,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: sp(hintTextFontSize ?? kfsTiny),
              color: hintTextColor ?? kTextColor2,
            ),
            fillColor: kWhiteColor,
            filled: true,
            border: _border,
            focusedBorder: _border,
            enabledBorder: _border,
          ),
        )
      ],
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? kSecondaryColor,
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
      borderRadius: BorderRadius.circular(sr(kfsVeryTiny)),
    );
  }
}
