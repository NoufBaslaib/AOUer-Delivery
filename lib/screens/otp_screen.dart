import 'dart:ui';

import 'package:delivery/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatelessWidget {
  static const String screenRoute = 'otp_screen';
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Varification Code',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Enter the verification code sent at ' +
                  "support@codingwitht.com",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: TextStyle(fontSize: 20),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              keyboardType: TextInputType.number,
              onCompleted: (pin) {
                print("Completed: " + pin);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(width: double.infinity),
            MyButton(title: 'Next', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
