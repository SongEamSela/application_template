import 'package:application_template/notifier/initial_screen_notifier.dart';
import 'package:application_template/screen/home_page_screen.dart';
import 'package:application_template/screen/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitialScreen extends HookConsumerWidget {
  const InitialScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _provider = ref.watch(initialScreenProvider);

    if (_provider.isSignedin == null) {
      return buildBackgroundLoading(context);
    } else if (_provider.isSignedin == true) {
      return const HomePageScreen();
    } else {
      return LoginPage();
    }
  }

  Scaffold buildBackgroundLoading(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
