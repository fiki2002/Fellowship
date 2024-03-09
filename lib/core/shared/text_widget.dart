import 'package:fellowship/core/core.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    Key? key,
    this.fontSize = kfsTiny,
    this.textColor = kBlack,
    this.fontWeight = w400,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.height,
    this.fontFamily,
    this.onTap,
    this.fontStyle,
    this.isDMSans = false,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final double? height;
  final String? fontFamily;
  final VoidCallback? onTap;
  final bool isDMSans;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: sp(fontSize!),
          // fontFamily: fontFamily ?? (isDMSans ? dmSans : cralika),
          color: textColor,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: decoration,
          height: height,
        ),
        textAlign: textAlign,
        overflow: overflow,
        softWrap: true,
        maxLines: maxLines,
      ),
    );
  }
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    Key? key,
    required this.text,
    required this.text2,
    this.fontSize = kfsTiny,
    this.fontSize2 = kfsTiny,
    this.textColor = kBlack,
    this.textColor2 = kBlack,
    this.textColor3 = kBlack,
    this.fontWeight = w400,
    this.fontWeight2 = w400,
    this.textAlign = TextAlign.justify,
    this.maxLines,
    this.overflow,
    this.decoration2 = TextDecoration.underline,
    this.decoration4 = TextDecoration.underline,
    this.fontFamily,
    this.onTap,
    this.onTap1,
    this.text3,
    this.text4,
    this.isDMSans = false,
  }) : super(key: key);

  final String text;
  final String text2;
  final String? text3;
  final String? text4;
  final double? fontSize;
  final double? fontSize2;
  final Color? textColor;
  final String? fontFamily;
  final Color? textColor2;
  final Color? textColor3;
  final FontWeight? fontWeight;
  final FontWeight? fontWeight2;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration2;
  final TextDecoration? decoration4;
  final GestureRecognizer? onTap;
  final GestureRecognizer? onTap1;
  final bool isDMSans;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.justify,
      maxLines: maxLines,
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: sp(fontSize!),
          color: textColor,
          fontWeight: fontWeight,
          // fontFamily: fontFamily ?? (isDMSans ? dmSans : cralika),
          overflow: overflow,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: text2,
            recognizer: onTap,
            style: TextStyle(
              fontSize: sp(fontSize2!),
              color: textColor2,
              // fontFamily: fontFamily ?? (isDMSans ? dmSans : cralika),
              fontWeight: fontWeight2,
              decoration: decoration2,
            ),
          ),
          TextSpan(
            text: text3,
            style: TextStyle(
              fontSize: sp(fontSize2!),
              color: textColor3,
              // fontFamily: fontFamily ?? (isDMSans ? dmSans : cralika),
              fontWeight: fontWeight2,
            ),
          ),
          TextSpan(
            text: text4,
            recognizer: onTap1,
            style: TextStyle(
              fontSize: sp(fontSize2!),
              color: textColor2,
              // fontFamily: fontFamily ?? (isDMSans ? dmSans : cralika),
              fontWeight: fontWeight2,
              decoration: decoration4,
            ),
          ),
        ],
      ),
    );
  }
}
