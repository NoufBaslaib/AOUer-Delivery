import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/image_string.dart';
import 'package:delivery/screens/recieve_order_page.dart';
import 'package:delivery/screens/registration_screen.dart';
import 'package:delivery/screens/type_order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapScreen extends StatefulWidget {
  static const String screenRoute = 'map_screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //To read the user email
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            children: [
              Container(child: Image.asset(AOUlogo)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome "),
                  //to print the user email
                  Text(user.email!),
                  MaterialButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RegistrationScreen()));
                    },
                    color: Colors.grey,
                    child: Text('Sign out'),
                  ),
                  SizedBox(height: 50),
                  MaterialButton(
                    onPressed: () async {
                      var user = await FirebaseFirestore.instance
                          .collection('customers')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get();
                      if (user.exists) {
                        Navigator.pushNamed(context, TypeOrder.screenRoute);
                      } else
                        Navigator.pushNamed(
                            context, ReceiveOrderPage.screenRoute);
                    },
                    color: Colors.white,
                    child: Text('Order'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
