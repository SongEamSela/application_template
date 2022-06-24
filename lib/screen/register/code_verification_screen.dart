import 'dart:io';

import 'package:application_template/config_constant/theme_constant.dart';
import 'package:application_template/route_config.dart';
import 'package:application_template/screen/register/set_password_screen.dart';
import 'package:application_template/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CodeVerificationScreen extends StatelessWidget {
  const CodeVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeConstant.hideAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(height: 50),
                  Text(
                    'Verification Code',
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ]),
                const SizedBox(height: 80),
                Pinput(
                  length: 6,
                ),
                const SizedBox(height: 90),
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteConfig.SET_PASSWORD_SCREEN,
                    );
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SetPasswordScreenScreen()));
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
