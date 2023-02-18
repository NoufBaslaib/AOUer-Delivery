// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// enum Role { admin, user }

// class UserData {
//   final String uid;
//   final String email;
//   final Role role;

//   UserData({
//     required this.uid,
//     required this.email,
//     required this.role,
//   });
// }

// class UserService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<UserData> getUserData(String uid) async {
//     final DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
//     final Map<String, dynamic> data = snap.data;

//     return UserData(
//       uid: uid,
//       email: data['email'],
//       role: Role.values.firstWhere((e) => e.toString() == data['role']),
//     );
//   }

//   Future<void> giveRole(String email, Role role) async {
//     final FirebaseUser user = (await _auth.fetchSignInMethodsForEmail(email: email)).first;
//     final String uid = user.uid;

//     await _firestore.collection('users').doc(uid).set({
//       'email': email,
//       'role': role.toString(),
//     },);
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType { driver, customer }

class UserData {
  final String uid;
  final String email;
  final UserType type;

  UserData({
    required this.uid,
    required this.email,
    required this.type,
  });
}

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String email, String password, UserType type) async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    final String uid = user!.uid;

    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'type': type.toString(),
    });
  }
}












