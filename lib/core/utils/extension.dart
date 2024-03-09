import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

/// extension for SVG

extension SvgExtension on String {
  /// SVG with color
  SvgPicture svg([Color? color]) => SvgPicture.asset(
        this,
        fit: BoxFit.scaleDown,
        // ignore: deprecated_member_use
        color: color,
      );
}

extension ContextExtension on BuildContext {
  AuthNotifier get auth => Provider.of<AuthNotifier>(this, listen: false);
  HomeNotifier get home => Provider.of<HomeNotifier>(this, listen: false);
  MemberNotifier get member => Provider.of<MemberNotifier>(this, listen: false);
}

extension ValidatingExtensions on String {
  String? validateAnyField({String? field}) {
    if (toString().isEmpty) {
      return '$field field is required ';
    } else {
      return null;
    }
  }

  String? validateEmail() {
    if (toString().isEmpty) {
      return 'Email field is required';
    }

    final pattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );

    if (pattern.hasMatch(this)) {
      return null;
    } else {
      return 'Invalid email';
    }
  }

  String? validateJustEmail() {
    if (toString().isNotEmpty) {
      final pattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      );

      if (pattern.hasMatch(this)) {
        return null;
      } else {
        return 'Invalid email';
      }
    }
    return null;
  }

  String? validatePhoneNumber() {
    if (toString().isEmpty) {
      return 'Phone number field is required';
    }

    RegExp regExp = RegExp(r'^\+?[0-9]+$');

    if (!regExp.hasMatch(toString())) {
      return 'Invalid phone number';
    }

    return null;
  }

  String? validatePassword() {
    if (isEmpty) {
      return 'Password is required';
    }

    if (!isValidPassword()) {
      return 'Password must contain at least 6 characters, which includes an'
          'uppercase, lowercase, digit and symbol';
    }

    return null;
  }

  bool isValidPassword() {
    if (length < 6) {
      return false;
    }

    if (!RegExp(r'[a-z]').hasMatch(this)) {
      return false;
    }

    if (!RegExp(r'[A-Z]').hasMatch(this)) {
      return false;
    }

    if (!RegExp(r'[0-9]').hasMatch(this)) {
      return false;
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this)) {
      return false;
    }

    return true;
  }
}

extension FirstNameExtension on String {
  String getFirstName() {
    if (toString().length > 1) {
      List<String> nameParts = split(' ');

      return nameParts[0];
    }
    return toString();
  }
}

extension InitialsExtension on String {
  String getInitials() {
    if (toString().length > 1) {
      List<String> nameParts = split(' ');

      List<String> initials =
          nameParts.map((part) => part[0].toUpperCase()).toList();

      return initials.join('');
    }
    return toString()[0];
  }
}
