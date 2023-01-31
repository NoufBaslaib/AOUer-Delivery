import 'package:delivery/screens/otp_screen.dart';
import 'package:delivery/widgets/text_feiled_widget.dart';
import 'package:flutter/material.dart';

import '../constract/color_string.dart';
import '../constract/image_string.dart';
import '../widgets/my_button.dart';

class ResetScreen extends StatefulWidget {
  static const String screenRoute = 'reset_pw_screen';
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
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
                ),
                const Text(
                  'Reset password',
                  style: TextStyle(fontSize: (25)),
                ),
                const SizedBox(
                  height: 30,
                ),
                FillTextWidget(
                    title: 'Enter your E-mail',
                    icon: Icons.email,
                    onChanged: () {}),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                    title: 'Send',
                    onPressed: () {
                      Navigator.pushNamed(context, OTPScreen.screenRoute);
                    })
              ],
            ),
            // ignore: prefer_const_constructors
          ],
        ),
      ),
    );
  }
}
