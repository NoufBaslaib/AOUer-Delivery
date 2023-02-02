// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:delivery/screens/map_sceaan.dart';
import 'package:delivery/screens/reset_pw_screen.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:delivery/widgets/text_feiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constract/color_string.dart';
import '../constract/image_string.dart';
import '../widgets/fill_password.dart';

class loginScreen extends StatefulWidget {
  static const String screenRoute = 'log_in';
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //log in function
  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AOUbackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //page logo
              Container(
                height: 180,
                child: Image.asset(
                  AOUlogo,
                ),
              ),

              //Title
              Text(
                'Log In',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 30,
              ),
              //Email TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Enter your Email',
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
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //Password TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Enter your password',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
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
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              )

              //SignIn button
              ,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: GestureDetector(
                  onTap: signIn,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text('Log in')),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                child: Text(
                  'forget your password?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 192, 97, 125),
                      fontSize: 15),
                ),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ResetScreen())),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
// class loginScreen extends StatefulWidget {
//   static const String screenRoute = 'log_in';

//   const loginScreen({super.key});

//   @override
//   State<loginScreen> createState() => _loginScreenState();
// }

// class _loginScreenState extends State<loginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   Future signIn() async {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim());
//   }

//   void dipose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }

//   final _auth = FirebaseAuth.instance;

//   //late String email;
//   //late String password;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AOUbackground,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   height: 180,
//                   child: Image.asset(AOUlogo),
//                 ),
//                 // ignore: prefer_const_constructors
//                 Text(
//                   'Login',
//                   style: const TextStyle(
//                       fontSize: (30), fontWeight: FontWeight.bold),
//                 ),
//                 // ignore: prefer_const_constructors
//                 SizedBox(
//                   height: 30,
//                 ),

//                 TextField(
//                   controller: _emailController,
//                   obscureText: false,
//                   textAlign: TextAlign.center,
//                   onChanged: ((value) {}),
//                   // ignore: prefer_const_constructors
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.email),
//                     hintText: 'Enter your Email',
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey, width: 1),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.green, width: 2),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),

//                 TextField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   textAlign: TextAlign.center,
//                   onChanged: ((value) {}),
//                   // ignore: prefer_const_constructors
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.lock),
//                     hintText: 'Enter your password',
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.grey, width: 1),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.green, width: 2),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(
//                   height: 9,
//                 ),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: GestureDetector(
//                     onTap: signIn,
//                     child: Container(
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(12)),
//                       child: Center(
//                         child: Text('Log in'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 9,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: TextButton(
//                     onPressed: () {
//                       showModalBottomSheet(
//                         backgroundColor: AOUbackground,
//                         context: context,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0)),
//                         builder: (context) => Container(
//                           padding: const EdgeInsets.all(30.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text('Make Selection!'),
//                               const Text('Select one of the options below'),
//                               const SizedBox(
//                                 height: 30.0,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.pushNamed(
//                                       context, ResetScreen.screenRoute);
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(20.0),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                       color: Colors.grey.shade200),
//                                   child: Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.mail_outline_rounded,
//                                         size: 60.0,
//                                       ),
//                                       const SizedBox(
//                                         width: 10.0,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: const [
//                                           Text('Reset via Email')
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 20.0,
//                               ),
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                   padding: const EdgeInsets.all(20.0),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                       color: Colors.grey.shade200),
//                                   child: Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.phone,
//                                         size: 60.0,
//                                       ),
//                                       const SizedBox(
//                                         width: 10.0,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: const [
//                                           Text('Reset via phone number')
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: const Text('forget your password'),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
