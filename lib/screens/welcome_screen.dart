import 'package:delivery/screens/registration_screen.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:flutter/material.dart';

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
              title: 'Customer',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
            ),
            MyButton(
                color: Color.fromARGB(255, 164, 162, 162),
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
