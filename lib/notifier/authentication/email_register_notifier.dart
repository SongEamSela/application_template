import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmailRegisterNotifier extends ChangeNotifier {
  String errorText = '';
  bool validateForm = false;

  validateEmail(String? value) {
    bool validate = EmailValidator.validate(value ?? '');
    if (!validate) {
      errorText = 'Please enter a valid email';
    } else {
      errorText = '';
    }
  }

  validateEmailForm() {
    if (errorText != '') {
      validateForm = false;
    } else {
      validateForm = true;
    }
    notifyListeners();
  }
}

final emailRegisterProvider = ChangeNotifierProvider.autoDispose<EmailRegisterNotifier>((ref) {
  return EmailRegisterNotifier();
});
