import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginNotifier extends ChangeNotifier {
  String errorEmailText = '';
  String errorPasswordText = '';
  bool validateForm = false;

  validateEmail(String? value) {
    bool validate = EmailValidator.validate(value ?? '');
    if (!validate) {
      errorEmailText = 'Please enter a valid email';
    } else {
      errorEmailText = '';
    }
  }

  validatePassword(String? value) {
    if (value == null || value == '') {
      errorPasswordText = 'Please enter your password';
      return;
    }
    if (value.length < 8) {
      errorPasswordText = 'Must be at least 8 charaters';
      return;
    } else {
      errorPasswordText = '';
    }
  }

  validateLoginForm() {
    if (errorEmailText != '' || errorPasswordText != '') {
      validateForm = false;
    } else {
      validateForm = true;
    }
    notifyListeners();
  }
}

final loginProvider = ChangeNotifierProvider.autoDispose<LoginNotifier>((ref) {
  return LoginNotifier();
});
