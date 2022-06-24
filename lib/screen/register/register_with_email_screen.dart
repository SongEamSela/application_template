import 'package:application_template/notifier/authentication/email_register_notifier.dart';
import 'package:application_template/route_config.dart';
import 'package:application_template/screen/register/code_verification_screen.dart';
import 'package:application_template/shared_widgets/custom_button.dart';
import 'package:application_template/shared_widgets/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterWithEmailScreen extends HookConsumerWidget {
  RegisterWithEmailScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _provider = ref.watch(emailRegisterProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(height: 70),
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
          SizedBox(
            height: 20,
          ),
          _termAndConditionWidget(context),
        ],
      ),
    );
  }

  _termAndConditionWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('By register an account,'),
          RichText(
            text: TextSpan(
              text: 'you agree to the ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: 'Term and Condition',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
