import 'package:fellowship/core/core.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.textSize = kfsTiny,
    this.height,
    this.width,
    this.useHeightOrWidth = true,
    this.textFontWeight = w400,
    this.circular = true,
    this.active = true,
    this.child,
  })  : busy = false,
        iconData = null,
        borderColor = null,
        iconSize = null,
        iconColor = null;

  const Button.withBorderLine({
    super.key,
    this.text,
    this.onTap,
    this.color = Colors.transparent,
    this.borderColor = kPrimaryColor,
    this.textColor = kPrimaryColor,
    this.textSize = kfsTiny,
    this.height,
    this.width,
    this.useHeightOrWidth = true,
    this.textFontWeight = w400,
    this.circular = true,
    this.active = true,
    this.child,
  })  : busy = false,
        iconData = null,
        iconSize = null,
        iconColor = null;

  const Button.loading({
    super.key,
    this.onTap,
    this.color,
    this.height,
    this.useHeightOrWidth = true,
    this.width,
  })  : busy = true,
        iconData = null,
        text = null,
        textColor = null,
        textSize = kfsTiny,
        textFontWeight = null,
        iconSize = null,
        iconColor = null,
        borderColor = null,
        child = null,
        active = true,
        circular = false;

  const Button.smallSized({
    super.key,
    this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.useHeightOrWidth = true,
    this.textSize = kfsTiny,
    this.height,
    this.width,
    this.textFontWeight = w400,
    this.circular = true,
    this.active = true,
    this.child,
  })  : busy = false,
        iconData = null,
        iconSize = null,
        borderColor = null,
        iconColor = null;

  const Button.textOnly({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor = kPrimaryColor,
    this.textSize = kfsTiny,
    this.textFontWeight = w400,
    this.useHeightOrWidth = false,
  })  : active = false,
        borderColor = null,
        busy = false,
        circular = false,
        color = null,
        height = null,
        child = null,
        iconColor = null,
        iconData = null,
        iconSize = null,
        width = null;

  const Button.icon({
    super.key,
    required this.iconData,
    required this.height,
    required this.width,
    required this.onTap,
    this.useHeightOrWidth = true,
    this.color,
    this.iconColor,
    this.iconSize,
    this.circular = true,
    this.active = true,
  })  : busy = false,
        text = null,
        borderColor = null,
        textColor = null,
        textSize = kfsTiny,
        child = null,
        textFontWeight = null;

  final String? text;
  final IconData? iconData;
  final void Function()? onTap;
  final bool busy;
  final bool active;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? textSize;
  final double? height;
  final double? width;
  final FontWeight? textFontWeight;
  final Color? iconColor;
  final double? iconSize;
  final bool circular;
  final bool? useHeightOrWidth;
  final Widget? child;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animateButton();
  }

  @override
  Widget build(BuildContext context) {
    double defaultHeight = h(kfs56);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      child: SizedBox(
        height: widget.useHeightOrWidth == false
            ? null
            : widget.height ?? defaultHeight,
        width: widget.width,
        child: TextButton(
          onPressed: () {
            widget.onTap?.call();
            _animationController.forward();
          },
          style: getButtonStyle(),
          child: widget.child ?? getButtonChild(),
        ),
      ),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child!,
        );
      },
    );
  }

  ButtonStyle getButtonStyle() {
    MaterialStateProperty<RoundedRectangleBorder> shape;

    if (widget.circular) {
      shape = MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sr(kfs100)),
          side: BorderSide(color: widget.borderColor ?? Colors.transparent),
        ),
      );
    } else {
      shape = MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sr(kSize5)),
          side: BorderSide(color: widget.borderColor ?? Colors.transparent),
        ),
      );
    }

    MaterialStateProperty<Color> backgroundColor;
    if (widget.busy) {
      backgroundColor = MaterialStateProperty.all(kPrimaryColor);
    } else if (widget.active == false) {
      backgroundColor = MaterialStateProperty.all(kWhiteColor);
    } else {
      backgroundColor =
          MaterialStateProperty.all(widget.color ?? kPrimaryColor);
    }

    return ButtonStyle(
      shape: shape,
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
      backgroundColor: backgroundColor,
    );
  }

  Widget getButtonChild() {
    if (widget.text == null) {
      if (widget.busy) {
        return SizedBox(
          height: h(21),
          width: w(21),
          child: const CircularProgressIndicator(),
        );
      } else {
        return Icon(
          widget.iconData,
          color: widget.iconColor ?? kWhiteColor,
          size: widget.iconSize ?? 20.0,
        );
      }
    } else {
      return Center(
        child: TextWidget(
          widget.text ?? 'no text',
          onTap: () {
            widget.onTap?.call();
            _animationController.forward();
          },
          isDMSans: true,
          textColor: widget.textColor ?? kWhiteColor,
          fontSize: widget.textSize,
          fontWeight: widget.textFontWeight,
        ),
      );
    }
  }

  void _animateButton() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
      ),
    );

    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
