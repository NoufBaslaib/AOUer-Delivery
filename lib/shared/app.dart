//import 'package:animated_card_input/components/home.component.dart';
import 'package:delivery/components/home.component.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  static const String screenRoute = 'app.dart';

  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Payment'),
    );
  }
}