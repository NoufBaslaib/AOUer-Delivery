import 'package:delivery/screens/otp_screen.dart';
import 'package:delivery/widgets/_feiled_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final JosKeys7 = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  Future verifyEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Form(
        key: JosKeys7,
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
                          'Reset Password',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
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

                        //Sign up button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: GestureDetector(
                            onTap: verifyEmail,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text('Send'),
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
        )));
  }
}
//     return Form(
//       child: Scaffold(
//         backgroundColor: AOUbackground,
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     height: 180,
//                     child: Image.asset(AOUlogo),
//                   ),
//                   const Text(
//                     'Reset password',
//                     style: TextStyle(fontSize: (25)),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 26),
//                     child: Container(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: TextFormField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             //prefixIcon: Icon(Icons.email),
//                             hintText: 'Enter your Email',
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 20),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10),
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: Colors.grey, width: 1),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey,
//                         maximumSize: Size.fromHeight(50)),
//                     icon: Icon(Icons.email_outlined),
//                     label: Text(
//                       'Reset Password',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     onPressed: (() {
//                       verifyEmail();
//                     }),
//                   ),
//                 ],
//               ),
//               // ignore: prefer_const_constructors
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
