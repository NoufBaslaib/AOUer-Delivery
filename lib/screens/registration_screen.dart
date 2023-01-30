import 'package:delivery/screens/log_in.dart';
import 'package:delivery/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:delivery/widgets/my_button.dart';

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
      backgroundColor: Color.fromARGB(255, 215, 212, 212),
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
                  child: Image.asset('images/AOUer_logo.PNG'),
                )
              ],
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 30,
            ),
            MyButton(
              color: Color.fromARGB(255, 164, 162, 162),
              title: 'Login',
              onPressed: () {
                Navigator.pushNamed(context, loginScreen.screenRoute);
              },
            ),
            MyButton(
                color: Color.fromARGB(255, 164, 162, 162),
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
