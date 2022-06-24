import 'package:application_template/mixin/toast.dart';
import 'package:application_template/notifier/authentication/local_auth_notifier.dart';
import 'package:application_template/notifier/authentication/social_auth_notifier.dart';
import 'package:application_template/route_config.dart';
import 'package:application_template/screen/home_page_screen.dart';
import 'package:application_template/screen/login/login_screen.dart';
import 'package:application_template/screen/register/sign_up_new_design/sign_up_account_screen.dart';
import 'package:application_template/services/sign_in_checker_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget with Toast {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _socialSignIn = ref.watch(socialAuthProvider);
    final _localAuth = ref.watch(LocalAuthProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lorem ipsum',
                      style: Theme.of(context).textTheme.headline3?.copyWith(color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteConfig.SIGNUP_SCREEN,
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpAccountScreen()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: Center(
                        child: Text(
                          'Sign up',
                          style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RouteConfig.LOGIN_SCREEN,
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: Center(
                        child: Text(
                          'Log in',
                          style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text('or connect with', style: Theme.of(context).textTheme.subtitle1),
              ),
              const Expanded(child: Divider()),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCamDigiKeyicon(),
                  _buildGoogleIcon(onTap: () async {
                    showLoading();
                    await _socialSignIn.signInwithGoogle();
                    hideLoading();
                    var value = await SignInCheckerService.call();
                    if (value == true) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageScreen(),
                          ),
                          (route) => false);
                    }
                  }),
                  _buildFaceBookIcon(
                    onTap: () async {
                      showLoading();
                      await _socialSignIn.loginWithFacebook();
                      hideLoading();
                      var value = await SignInCheckerService.call();
                      if (value == true) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePageScreen(),
                            ),
                            (route) => false);
                      }
                    },
                  ),
                  _buidAppleIcon(onTap: () {}),
                  _buildFaceIdAuth(onTap: () async {
                    showLoading();
                    await _localAuth.localAuth();
                    hideLoading();
                  })
                ],
              ),
            ),
            const SizedBox(height: 36),
            // Center(
            //   child: RichText(
            //     text: TextSpan(
            //       text: "Don't have account yet? ",
            //       style: Theme.of(context).textTheme.subtitle1,
            //       children: <TextSpan>[
            //         TextSpan(
            //           text: 'Register',
            //           style: TextStyle(
            //             color: Theme.of(context).primaryColor,
            //             decoration: TextDecoration.underline,
            //           ),
            //           recognizer: TapGestureRecognizer()
            //             ..onTap = () {
            //               Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPageWrapper()));
            //             },
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  _buildCamDigiKeyicon({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/social_sign_in_icon/camdigikey.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _buildGoogleIcon({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
          image: const DecorationImage(
            image: AssetImage('assets/social_sign_in_icon/google-login-icon.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _buildFaceIdAuth({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        padding: EdgeInsets.all(18),
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          // border: Border.all(color: Colors.blue),
          image: const DecorationImage(
            image: AssetImage('assets/social_sign_in_icon/face-id.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _buildFaceBookIcon({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 54,
        child: Image.asset('assets/social_sign_in_icon/f_logo_RGB-Blue_58.png'),
      ),
    );
  }

  _buidAppleIcon({void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/social_sign_in_icon/apple_login_icon.png'),
            opacity: 0.3,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _buildButtonSignInWithGoogle(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            border: Border.all(
              width: 2,
              color: Color(0xFF4285F4),
            ),
          ),
          child: Image.asset(
            'assets/social_sign_in_icon/google-login-icon.jpeg',
            height: 52,
          ),
        ),
        Expanded(
          child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF4285F4),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Center(
                  child: Text(
                'Sign up with Google',
                style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
              ))),
        ),
      ],
    );
  }

  _buildButtonSignInWithFacebook(BuildContext context) {
    return Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFF1877F2),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/social_sign_in_icon/f_logo_RGB-White_58.png',
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Login with Facebook',
                      style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                    )),
              ),
            ),
          ],
        ));
  }

  _buildButtonLoginWithApple(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.black,
      ),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset('assets/social_sign_in_icon/apple_login_icon.png'),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Sign in with Apple',
              style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
