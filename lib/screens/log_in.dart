import 'dart:io';

import 'package:delivery/screens/map_sceaan.dart';
import 'package:delivery/screens/reset_pw_screen.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:delivery/widgets/text_feiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constract/color_string.dart';
import '../constract/image_string.dart';

class loginScreen extends StatefulWidget {
  static const String screenRoute = 'log_in';

  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
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
                  'Login',
                  style: const TextStyle(
                      fontSize: (30), fontWeight: FontWeight.bold),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 30,
                ),

                FillTextWidget(
                    title: 'Enter your E-mail',
                    icon: Icons.person_outline_outlined,
                    onChanged: () {}),

                const SizedBox(
                  height: 20,
                ),

                FillTextWidget(
                    title: 'Enter your password',
                    icon: Icons.lock,
                    onChanged: () {}),

                const SizedBox(
                  height: 9,
                ),
                MyButton(
                    title: 'Login',
                    onPressed: () async {
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, MapScreen.screenRoute);
                        }
                      } catch (e) {
                        print(e);
                      }
                    }),
                const SizedBox(
                  height: 9,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: AOUbackground,
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Make Selection!'),
                              const Text('Select one of the options below'),
                              const SizedBox(
                                height: 30.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ResetScreen.screenRoute);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.shade200),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.mail_outline_rounded,
                                        size: 60.0,
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text('Reset via Email')
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey.shade200),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 60.0,
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text('Reset via phone number')
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Text('forget your password'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
