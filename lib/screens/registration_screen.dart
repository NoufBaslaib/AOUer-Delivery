import 'package:delivery/screens/log_in.dart';
import 'package:delivery/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:delivery/widgets/my_button.dart';

import '../constract/color_string.dart';
import '../constract/image_string.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              title: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.screenRoute);
              },
            ),
            MyButton(
                title: 'SignUp',
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.screenRoute);
                })
          ],
        ),
      ),
    );
  }
}
