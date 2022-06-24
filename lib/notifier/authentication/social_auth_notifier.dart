import 'package:application_template/storage/login_token_storage.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SocialAuthNotifier extends ChangeNotifier {
  // bool isSignIn = false;

  Future<void> signInwithGoogle() async {
    String? token = await _getGoogleIdToken();

    if (token == null) return;
    await _saveLoginToken(token);
  }

  Future<String?> _getGoogleIdToken() async {
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().signOut();
    }

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        if (await FirebaseAuth.instance.currentUser != null) await FirebaseAuth.instance.signOut();
        await FirebaseAuth.instance.signInWithCredential(credential);
      } on FirebaseException catch (e) {
        print(e.message);
        BotToast.showText(text: e.message ?? 'Error');
        // showError(context: context, title: tr('msg.error'), subtitle: e.message);
        return null;
      }

      var idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      print(idToken);

      if (await GoogleSignIn().isSignedIn()) await GoogleSignIn().signOut();
      if (idToken == null) return null;
      return idToken;
    }
  }

  loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['user_birthday', 'user_gender'],
    );
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      final userData = await FacebookAuth.i.getUserData(
        fields: "name,birthday,gender",
      );
      print(accessToken.token);
      String? token = accessToken.token;
      await _saveLoginToken(token);
    } else {
      print(result.status);
      print(result.message);
    }
  }

  _saveLoginToken(String? token) async {
    if (token == null) return;

    var loginStorage = LoginTokenStorage();
    await loginStorage.saveString(value: token);
  }
}

final socialAuthProvider = ChangeNotifierProvider<SocialAuthNotifier>((ref) {
  return SocialAuthNotifier();
});
