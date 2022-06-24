import 'dart:io';

import 'package:application_template/screen/register/register_with_email_screen.dart';
import 'package:application_template/screen/register/register_with_phone_screen.dart';
import 'package:flutter/material.dart';

class RegisterPageWrapper extends StatelessWidget {
  const RegisterPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 6),
            child: Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      'Register Account',
                      style: Theme.of(context).textTheme.headline5?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ]),
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).hoverColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TabBar(
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.email),
                              SizedBox(width: 8),
                              Text('Email'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.phone),
                              SizedBox(width: 8),
                              Text('Mobile Phone'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            RegisterWithEmailScreen(),
            RegisterWithPhoneNumberScreen(),
          ],
        ),
      ),
    );
  }
}
