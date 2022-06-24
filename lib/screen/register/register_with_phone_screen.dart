import 'package:application_template/notifier/authentication/phone_register_notifier.dart';
import 'package:application_template/route_config.dart';
import 'package:application_template/shared_widgets/custom_button.dart';
import 'package:application_template/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'code_verification_screen.dart';

class RegisterWithPhoneNumberScreen extends HookConsumerWidget {
  RegisterWithPhoneNumberScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _provider = ref.watch(phoneRegisterProvider);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: CustomTextFeild(
              hintText: 'Mobile',
              errorText: _provider.errorText,
              validator: (value) {
                _provider.validateMobilePhone(value);
                return;
              },
            ),
          ),
          const SizedBox(height: 70),
          CustomButton(
            onPressed: () {
              _formKey.currentState!.validate();
              _provider.validateMobileForm();
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
          const SizedBox(height: 20),
          _termAndConditionWidget(context),
        ],
      ),
    );
  }

  _termAndConditionWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('By register an account,'),
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
