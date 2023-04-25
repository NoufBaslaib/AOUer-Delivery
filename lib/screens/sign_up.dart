import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/screens/choose_location_screen.dart';
import 'package:delivery/screens/edit_profile_screen.dart';
import 'package:delivery/screens/map_sceaan.dart';
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
import 'home_page.dart';

class SignUpScreen extends StatefulWidget {
  static const String screenRoute = 'sign_up';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final JosKeys4 = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _userType = 'customer';
  String errorMessage = '';

  void _signUp() async {
    if (JosKeys4.currentState!.validate()) {
      JosKeys4.currentState!.save();

      // Check if the user selected 'driver' or 'customer' in the dropdown list
      if (_userType == 'driver') {
        print('Adding user data to drivers collection');
        // Add the user data to the 'drivers' collection in Firebase
        final DocumentReference<Map<String, dynamic>> collection =
            FirebaseFirestore.instance
                .collection('drivers')
                .doc(FirebaseAuth.instance.currentUser!.uid);
        await collection.set({
          'email': _emailController.text,
          'password': _passwordController.text,
          'id': '',
          'name': '',
          'phone': '',
          'profilePic': '',
          'rating': '',
        });
        print('User data added to drivers collection');
      } else if (_userType == 'customer') {
        print('Adding user data to customers collection');
        // Add the user data to the 'customers' collection in Firebase
        final DocumentReference<Map<String, dynamic>> collection =
            FirebaseFirestore.instance
                .collection('customers')
                .doc(FirebaseAuth.instance.currentUser!.uid);
        await collection.set(
          {
            'email': _emailController.text,
            'password': _passwordController.text,
            'id': '',
            'name': '',
            'phone': '',
            'profilePic': '',
            'rating': '',
            'location': {}
          },
        );

        print('User data added to customers collection');
      }
      // Get.to(EditProfileScreen(userType: _userType));
    }
  }

  void dipose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: JosKeys4,
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

                      SizedBox(
                        height: 30,
                      ),

                      _buildUserTypeDropdown(),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 20,
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
                            if (JosKeys4.currentState!.validate()) {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => HomeNavBar(userType: _userType,)));
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                _signUp();
                                print('the userType is=${_userType}');
                                errorMessage = '';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        _userType == 'customer'
                                            ? GoogleMapScreen()
                                            : HomeNavBar(userType: _userType),
                                  ),
                                );
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

  Widget _buildUserTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: DropdownButtonFormField<String>(
        value: _userType,
        items: [
          DropdownMenuItem(
            value: 'customer',
            child: const Text('Customer'),
          ),
          DropdownMenuItem(
            value: 'driver',
            child: const Text('Driver'),
          ),
        ],
        onChanged: (String? value) {
          setState(() {
            _userType = value!;
          });
        },
        decoration: const InputDecoration(
          labelText: 'User type',
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
    );
  }
}
