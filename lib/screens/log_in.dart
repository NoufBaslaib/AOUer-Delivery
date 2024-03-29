import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/screens/recieve_order_page.dart';
import 'package:delivery/screens/receive_prices.dart';
import 'package:delivery/screens/registration_screen.dart';
import 'package:delivery/screens/type_order_screen.dart';

import 'edit_profile_screen.dart';
import 'map_sceaan.dart';
import 'reset_pw_screen.dart';
import '../widgets/my_button.dart';
import '../widgets/_feiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constract/color_string.dart';
import '../constract/image_string.dart';
import '../widgets/fill_password.dart';

class LoginScreen extends StatefulWidget {
  static const String screenRoute = 'log_in';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _JosKeys4 = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';
  //to show the loading
  bool isLoading = false;

  //log in function
  Future signIn() async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _JosKeys4,
      child: Scaffold(
        backgroundColor: AOUbackground,
        appBar: AppBar(
          backgroundColor: AOUAppBar,
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenRoute);
              },
              icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
          title: Text('log in', style: Theme.of(context).textTheme.headline4),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      //page logo
                      Container(
                        height: 180,
                        child: Image.asset(AOUlogo),
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        'log in',
                        style: const TextStyle(fontSize: (30), fontWeight: FontWeight.bold),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 30,
                      ),
                      //email Text Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Enter your Email',
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      //password text field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                hintText: 'Enter your password',
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      //Sign up button
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: MaterialButton(
                          onPressed: () async {
                            //next line to show loading also
                            setState(() {});
                            if (_JosKeys4.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                                errorMessage = '';

                                final DocumentSnapshot<Map<String, dynamic>> ref = await FirebaseFirestore.instance.collection('customers').doc(FirebaseAuth.instance.currentUser!.uid).get();

                                if (ref.data() == null) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    ReceiveOrderPage.screenRoute,
                                  );
                                } else {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    TypeOrder.screenRoute,
                                  );
                                }
                              } on FirebaseAuthException catch (error) {
                                errorMessage = error.message!;
                              }
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text('Log in'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: Text(
                          'forget your password?',
                          style: TextStyle(decoration: TextDecoration.underline, color: Color.fromARGB(255, 192, 97, 125), fontSize: 15),
                        ),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetScreen())),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
