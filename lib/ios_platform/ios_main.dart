import 'package:application_template/shared_widgets/custom_button.dart';
import 'package:application_template/storage/login_token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class IOSMian extends StatelessWidget {
  const IOSMian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome to IOS Application'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: CustomButton(
              title: 'Log out',
              onPressed: () async {
                var tokenStorage = LoginTokenStorage();
                await tokenStorage.removeString();
                Phoenix.rebirth(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
