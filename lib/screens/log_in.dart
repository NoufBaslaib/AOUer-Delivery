import 'dart:io';

import 'package:delivery/screens/map_sceaan.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                ),
                // ignore: prefer_const_constructors
                Text(
                  'Login',
                  style: TextStyle(fontSize: (30), fontWeight: FontWeight.bold),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 30,
                ),

                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: ((value) {
                    email = value;
                  }),
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: 'Enter your E-mail',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: ((value) {
                    password = value;
                  }),
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                MyButton(
                    color: Color.fromARGB(255, 164, 162, 162),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
