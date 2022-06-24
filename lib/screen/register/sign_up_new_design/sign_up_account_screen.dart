import 'package:application_template/config_constant/theme_constant.dart';
import 'package:application_template/notifier/authentication/email_register_notifier.dart';
import 'package:application_template/notifier/authentication/phone_register_notifier.dart';
import 'package:application_template/route_config.dart';
import 'package:application_template/screen/register/code_verification_screen.dart';
import 'package:application_template/shared_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpAccountScreen extends HookConsumerWidget {
  SignUpAccountScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isSelectEmail = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailProvider = ref.watch(emailRegisterProvider);
    final _phoneProvider = ref.watch(phoneRegisterProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ThemeConstant.hideAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign up',
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
              ValueListenableBuilder(
                valueListenable: isSelectEmail,
                builder: (context, bool value, _) {
                  return Column(
                    children: [
                      Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              isSelectEmail.value
                                  ? _buildEmailTextFeild(_emailProvider)
                                  : _buildPhoneNumberTextFeild(context, _phoneProvider),
                            ],
                          )),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              isSelectEmail.value = true;
                            },
                            child: _emailIcon(value),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              isSelectEmail.value = false;
                            },
                            child: _phoneIcon(!value),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                onPressed: () {
                  _formKey.currentState!.validate();
                  if (isSelectEmail.value) {
                    _emailProvider.validateEmailForm();
                    if (_emailProvider.validateForm) {
                      Navigator.pushNamed(
                        context,
                        RouteConfig.VERIFICATION_SCREEN,
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CodeVerificationScreen()));
                    }
                  } else {
                    _phoneProvider.validateMobileForm();
                    if (_phoneProvider.validateForm) {
                      Navigator.pushNamed(
                        context,
                        RouteConfig.VERIFICATION_SCREEN,
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => CodeVerificationScreen()));
                    }
                  }
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: Center(
                    child: Text(
                      'Continue',
                      style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              _termAndConditionWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  _termAndConditionWidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'By register an account,',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          RichText(
            text: TextSpan(
              text: 'you agree to the ',
              style: Theme.of(context).textTheme.subtitle1,
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

  _buildPhoneNumberTextFeild(BuildContext context, PhoneRegisterNotifier provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 59,
          decoration: BoxDecoration(color: Theme.of(context).hoverColor),
          child: InternationalPhoneNumberInput(
            validator: (value) {
              provider.validateMobilePhone(value);
              return;
            },
            onInputChanged: (value) {
              print(value);
            },
            inputDecoration: const InputDecoration(
              hintText: 'Phone Number',
              border: InputBorder.none,
            ),
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: const TextStyle(color: Colors.black),
            formatInput: false,
            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
            countries: const ['KH'],
          ),
        ),
        if (provider.errorText != '')
          Column(
            children: [
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5),
                child: Text(
                  provider.errorText,
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              ),
            ],
          )
      ],
    );
  }

  _buildEmailTextFeild(EmailRegisterNotifier provider) {
    return CustomTextFeild(
      hintText: 'Email',
      errorText: provider.errorText,
      validator: (value) {
        provider.validateEmail(value);
        return;
      },
    );
  }

  _emailIcon(bool isSelcted) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelcted ? Color(0xFF59A2F7) : Colors.black.withOpacity(0.30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Icon(
        Icons.mail,
        color: Colors.white,
        size: 42,
      ),
    );
  }

  _phoneIcon(bool isSelcted) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelcted ? Color(0xFF59A2F7) : Colors.black.withOpacity(0.30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Icon(
        Icons.phone,
        color: Colors.white,
        size: 42,
      ),
    );
  }
}
