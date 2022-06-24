import 'package:application_template/shared_widgets/animation_tab_bar.dart';
import 'package:application_template/shared_widgets/custom_button.dart';
import 'package:application_template/storage/login_token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          GestureDetector(
            onTap: (() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AnimationTabBar()));
            }),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to Home Page',
            style: Theme.of(context).textTheme.headline5,
          ),
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

// mobile screen mode , webview mode