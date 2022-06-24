import 'package:application_template/config_constant/theme_constant.dart';
import 'package:application_template/notifier/authentication/email_register_notifier.dart';
import 'package:application_template/route_config.dart';
import 'package:application_template/screen/register/code_verification_screen.dart';
import 'package:application_template/shared_widgets/custom_button.dart';
import 'package:application_template/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordScreen extends HookConsumerWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _provider = ref.watch(emailRegisterProvider);
    return Scaffold(
      appBar: ThemeConstant.hideAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(height: 50),
                  Text(
                    'Forgot Password',
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ]),
                const SizedBox(height: 80),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: CustomTextFeild(
                    hintText: 'Email',
                    errorText: _provider.errorText,
                    validator: (value) {
                      _provider.validateEmail(value);
                      return;
                    },
                  ),
                ),
                const SizedBox(height: 70),
                CustomButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                    _provider.validateEmailForm();

                    if (_provider.validateForm) {
                      Navigator.pushNamed(
                        context,
                        RouteConfig.VERIFICATION_SCREEN,
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CodeVerificationScreen()));
                    }
                  },
                  title: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
