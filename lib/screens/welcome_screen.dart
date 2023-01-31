import 'package:delivery/screens/registration_screen.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:flutter/material.dart';

import '../constract/color_string.dart';
import '../constract/image_string.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AOUbackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset(AOUlogo),
                )
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 30,
            ),
            MyButton(
              title: 'Customer',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
            ),
            MyButton(
                title: 'Delivery',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.screenRoute);
                })
          ],
        ),
      ),
    );
  }
}
