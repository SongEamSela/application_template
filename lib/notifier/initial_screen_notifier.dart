import 'package:application_template/services/sign_in_checker_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitialScreenNotifier extends ChangeNotifier {
  bool? _isSignedin;

  load() async {
    var value = await SignInCheckerService.call();
    Future.delayed(Duration(seconds: 2), () {
      setIsSignedin(value);
    });
  }

  setIsSignedin(bool value) {
    if (_isSignedin == value) {
      return;
    }
    _isSignedin = value;
    notifyListeners();
  }

  bool? get isSignedin => _isSignedin;
}

final initialScreenProvider = ChangeNotifierProvider<InitialScreenNotifier>((ref) {
  return InitialScreenNotifier()..load();
});
