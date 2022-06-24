import 'package:application_template/config_constant/theme_constant.dart';
import 'package:application_template/notifier/authentication/login_notifier.dart';
import 'package:application_template/route_config.dart';
import 'package:application_template/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'forgot_password_screen.dart';

class LoginScreen extends HookConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _provider = ref.watch(loginProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ThemeConstant.hideAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log in Account',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextFeild(
                        hintText: 'Email or Phone number',
                        errorText: _provider.errorEmailText,
                        validator: (value) {
                          _provider.validateEmail(value);
                          return;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFeild(
                        hintText: 'Password',
                        errorText: _provider.errorPasswordText,
                        validator: (value) {
                          _provider.validatePassword(value);
                          return;
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 32),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                onPressed: () {
                  _formKey.currentState!.validate();
                  _provider.validateLoginForm();
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: Center(
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteConfig.FORGOT_PASSWORD_SCREEN,
                    );
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                  },
                  child: Text(
                    'Forgot your password?',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).primaryColorDark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
