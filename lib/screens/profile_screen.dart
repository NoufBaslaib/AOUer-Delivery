import 'package:delivery/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:delivery/widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  static const String screenRoute = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyButton(
              color: Color.fromARGB(255, 164, 162, 162),
              title: 'Sign Up',
              onPressed: () async {
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.screenRoute);
              }),
        ],
      ),
    ));
  }
}
