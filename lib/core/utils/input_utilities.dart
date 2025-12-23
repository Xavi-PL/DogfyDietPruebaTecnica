import 'package:flutter/services.dart';

class InputUtilities {
  static List<TextInputFormatter> phoneInputFormatters() {
    return [FilteringTextInputFormatter.digitsOnly];
  }

  static List<TextInputFormatter> emailInputFormatters() {
    return [EmailInputFormatter()];
  }
}

class EmailInputFormatter extends TextInputFormatter {
  static final _allowedChars = RegExp(r'[a-zA-Z0-9._%+\-@]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // Block spaces
    if (text.contains(' ')) {
      return oldValue;
    }

    // Allow only valid characters
    if (!text.split('').every((c) => _allowedChars.hasMatch(c))) {
      return oldValue;
    }

    // Allow only one "@"
    final atCount = '@'.allMatches(text).length;
    if (atCount > 1) {
      return oldValue;
    }

    return newValue;
  }
}
