import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/helpers.dart';
import 'package:delivery/screens/log_in.dart';
import 'package:delivery/screens/map_sceaan.dart';
import 'package:delivery/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/recieve_order_page.dart';
import '../screens/type_order_screen.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          mPrint("Current User :: ${snapshot.data.toString()}");
          // if (!snapshot.data == null) return getLoading();

          if (snapshot.data == null) return RegistrationScreen();

          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('customers').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
            builder: (_, snapshotType) {
              if (!snapshotType.hasData) return getLoading();

              //  Driver
              if (snapshotType.data!.data() == null) {
                return ReceiveOrderPage();
                // User
              } else {
                var data = snapshotType.data!.data() as Map<String, dynamic>;
                return TypeOrder(
                  name: data['name'],
                  phoneNumber: data['phone'],
                );
              }
            },
          );
        },
      ),
    );
  }
}
