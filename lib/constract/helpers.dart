import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User getLoggedInUser() {
  return FirebaseAuth.instance.currentUser!;
}

getLoading() => Center(
      child: CircularProgressIndicator(),
    );

void mPrint(String text) {
  print('\x1B[33m$text\x1B[0m');
}
