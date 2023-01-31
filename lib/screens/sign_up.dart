// ignore_for_file: prefer_const_constructors
import 'package:delivery/screens/map_sceaan.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constract/color_string.dart';
import '../constract/image_string.dart';
import '../widgets/text_feiled_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String screenRoute = 'sign_up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
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
                // ignore: prefer_const_constructors
                Text(
                  'SignUp',
                  style: TextStyle(fontSize: (30), fontWeight: FontWeight.bold),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 30,
                ),
                FillTextWidget(
                  icon: Icons.person_outline_outlined,
                  onChanged: () {},
                  title: 'Enter your Name',
                ),

                SizedBox(
                  height: 20,
                ),
                FillTextWidget(
                    title: 'Enter your phone number',
                    icon: Icons.phone,
                    onChanged: () {}),

                SizedBox(
                  height: 20,
                ),

                FillTextWidget(
                    title: 'Enter your E-mail',
                    icon: Icons.email,
                    onChanged: () {}),

                SizedBox(
                  height: 20,
                ),

                FillTextWidget(
                    title: 'Enter your password',
                    icon: Icons.lock,
                    onChanged: () {}),

                SizedBox(
                  height: 9,
                ),
                MyButton(
                    title: 'Sign Up',
                    onPressed: () async {
                      print(email);
                      print(password);

                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        Navigator.pushNamed(context, MapScreen.screenRoute);
                      } catch (e) {
                        print(e);
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
