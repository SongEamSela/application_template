import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PhoneRegisterNotifier extends ChangeNotifier {
  String errorText = '';
  bool validateForm = false;

  validateMobilePhone(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value ?? '')) {
      errorText = "Please enter valid mobile number";
    } else {
      errorText = '';
    }
  }

  validateMobileForm() {
    if (errorText != '') {
      validateForm = false;
    } else {
      validateForm = true;
    }
    notifyListeners();
  }
}

final phoneRegisterProvider = ChangeNotifierProvider.autoDispose<PhoneRegisterNotifier>((ref) {
  return PhoneRegisterNotifier();
});
