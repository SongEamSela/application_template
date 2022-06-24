import 'package:application_template/initial_screen.dart';
import 'package:application_template/screen/home_page_screen.dart';
import 'package:application_template/screen/login/forgot_password_screen.dart';
import 'package:application_template/screen/login/login_screen.dart';
import 'package:application_template/screen/register/code_verification_screen.dart';
import 'package:application_template/screen/register/set_password_screen.dart';
import 'package:application_template/screen/register/sign_up_new_design/sign_up_account_screen.dart';
import 'package:flutter/material.dart';

class RouteConfig {
  // static const String MAIN_SCREEN = '/';
  // static const String MAIN_SCREEN = '/';
  static const String HOME = '/home';
  static const String LOGIN_SCREEN = '/login';
  static const String SIGNUP_SCREEN = '/sign_up';
  static const String VERIFICATION_SCREEN = 'verification_screen';
  static const String SET_PASSWORD_SCREEN = 'set_password_screen';
  static const String FORGOT_PASSWORD_SCREEN = 'forgot_password_screen';

  static Map<String, WidgetBuilder> routeConfigs() {
    Map<String, WidgetBuilder> routes = {
      // '$MAIN_SCREEN': (context) => InitialScreen(),
      '$HOME': (context) => HomePageScreen(),
      '$LOGIN_SCREEN': (context) => LoginScreen(),
      '$SIGNUP_SCREEN': (context) => SignUpAccountScreen(),
      '$VERIFICATION_SCREEN': (context) => CodeVerificationScreen(),
      '$SET_PASSWORD_SCREEN': (context) => SetPasswordScreenScreen(),
      '$FORGOT_PASSWORD_SCREEN': (context) => ForgotPasswordScreen(),
    };
    return routes;
  }
}
