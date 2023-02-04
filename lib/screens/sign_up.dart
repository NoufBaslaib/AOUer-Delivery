// ignore_for_file: prefer_const_constructors

import 'package:delivery/screens/edit_profile_screen.dart';
import 'package:delivery/screens/map_sceaan.dart';
import 'package:delivery/screens/welcome_screen.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../constract/color_string.dart';
import '../constract/image_string.dart';
import '../widgets/fill_password.dart';
import '../widgets/signup_fill_password.dart';
import '../widgets/signup_text_field.dart';
import '../widgets/_feiled_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const String screenRoute = 'sign_up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';

  // Future signUp() async {
  //   final isValid = formKey.currentState!.validate();
  //   if (!isValid) return;

  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim());
  //     Navigator.of(context).pushNamed(MapScreen.screenRoute);
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //   }
  // }

  void dipose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  final _auth = FirebaseAuth.instance;

  //late String email;
  //late String password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: AOUbackground,
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
                        'Sign Up',
                        style: const TextStyle(
                            fontSize: (30), fontWeight: FontWeight.bold),
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !email.contains('@aou.edu.sa')
                                  ? 'Enter an email contain @aou.edu.sa'
                                  : null,
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? 'Enter at least 6 digits'
                                      : null,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      //Sign up button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {});
                            if (formKey.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                errorMessage = '';
                                Navigator.of(context)
                                    .pushNamed(EditProfileScreen.screenRoute);
                              } on FirebaseAuthException catch (error) {
                                errorMessage = error.message!;
                              }
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text('Sign up'),
                            ),
                          ),
                        ),
                      ),
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

  //final _auth = FirebaseAuth.instance;

  // late String email;
  // late String password;
//   @override
//   Widget build(BuildContext context) {
//     //final controller = Get.put(SignUpCntroller());
//     //final _formKey = GlobalKey<FormState>();
//     return  Scaffold(
//         backgroundColor: AOUbackground,
//         body: SingleChildScrollView(
//           //key: _formKey,
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Column(children: [
//                 Container(
//                   height: 180,
//                   child: Image.asset(AOUlogo),
//                 ),
//                 // ignore: prefer_const_constructors
//                 Text(
//                   'SignUp',
//                   style: TextStyle(fontSize: (30), fontWeight: FontWeight.bold),
//                 ),
//                 // ignore: prefer_const_constructors
//                 SizedBox(
//                   height: 30,
//                 ),
//                 SignUpFormWidget(),
//               ]

//                   // FillTextWidget(
//                   //   icon: Icons.person_outline_outlined,
//                   //   onChanged: (value) {},
//                   //   title: 'Enter your Name',
//                   // ),

//                   // SizedBox(
//                   //   height: 20,
//                   // ),
//                   // FillTextWidget(
//                   //     title: 'Enter your phone number',
//                   //     icon: Icons.phone,
//                   //     onChanged: (value) {}),

//                   // SizedBox(
//                   //   height: 20,
//                   // ),

//                   // SignUpTextWidget(
//                   //     controller: controller.email,
//                   //     title: 'Enter your E-mail',
//                   //     icon: Icons.email,
//                   //     onChanged: (value) {}),

//                   // SizedBox(
//                   //   height: 20,
//                   // ),

//                   //   SignUpPasswordField(
//                   //     cotroller: controller.password,
//                   //     icon: Icons.lock,
//                   //     onChanged: (value) {},
//                   //     title: 'Enter your password',
//                   //     obscureText: true,
//                   //   ),

//                   //   SizedBox(
//                   //     height: 9,
//                   //   ),
//                   //   MyButton(
//                   //       title: 'Sign Up',
//                   //       onPressed: () async {
//                   //         // print(email);
//                   //         // print(password);

//                   //         // try {
//                   //         //   final newUser =
//                   //         //       await _auth.createUserWithEmailAndPassword(
//                   //         //           email: email, password: password);
//                   //         //   Navigator.pushNamed(context, MapScreen.screenRoute);
//                   //         // } catch (e) {
//                   //         //   print(e);
//                   //         // }

//                   //         if (_formKey.currentState!.validate()) {
//                   //           SignUpCntroller.instance.registerUser(
//                   //               controller.email.text.trim(),
//                   //               controller.password.text.trim());
//                   //         }
//                   //       }),
//                   // ],
//                   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SignUpFormWidget extends StatelessWidget {
//   const SignUpFormWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(SignUpCntroller());
//     final _formKey = GlobalKey<FormState>();
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 20.0),
//       child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: controller.name,
//                 decoration: const InputDecoration(
//                   label: Text('Enter your name'),
//                   prefixIcon: Icon(Icons.person),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: controller.phoneNumber,
//                 decoration: const InputDecoration(
//                   label: Text('Enter your phone number'),
//                   prefixIcon: Icon(Icons.phone),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: controller.email,
//                 decoration: const InputDecoration(
//                   label: Text('Enter youe email'),
//                   prefixIcon: Icon(Icons.email),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 controller: controller.password,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   label: Text('Enter your password'),
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       SignUpCntroller.instance.registerUser(
//                           controller.email.text.trim(),
//                           controller.password.text.trim());
//                     }
//                   },
//                   child: const Text('SignUp'),
//                 ),
//               ),
//             ],
//           )));
    
//   }
// }
