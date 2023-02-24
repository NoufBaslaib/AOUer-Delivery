// app.dart

import 'package:flutter/material.dart';
import 'package:delivery/screens/location_detail/location_detail.dart';
import 'style.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: LocationDetail(),
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(titleSmall: AppBarTextStyle),
            ),
            textTheme: TextTheme(
              titleMedium: TitleTextStyle,
              bodyMedium: Body1TextStyle,
            )));
  }
}
