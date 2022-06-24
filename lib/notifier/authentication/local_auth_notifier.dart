import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthNotifier extends ChangeNotifier {
  localAuth() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biome trics $e");
    }

    print("biometric is available: $canCheckBiometrics");

//
    List<BiometricType> availableBiometrics = [];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {
        print("Avalible Biomatrics: $ab");
      });
    } else {
      print("no biometrics are available");
    }
    //

    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(biometricOnly: true),
        // authMessages: const <AuthMessages>[
        //   AndroidAuthMessages(
        //     signInTitle: 'Oops! Biometric authentication required!',
        //     cancelButton: 'No thanks',
        //   ),
        //   IOSAuthMessages(
        //     cancelButton: 'No thanks',
        //   )
        // ],
      );
    } catch (e) {
      print("error using biometric auth: $e");
    }
    print("authenticated: $authenticated");
  }
}

final LocalAuthProvider = ChangeNotifierProvider<LocalAuthNotifier>((ref) {
  return LocalAuthNotifier();
});
