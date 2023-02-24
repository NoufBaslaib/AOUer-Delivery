import 'package:delivery/auth/auth.dart';
import 'package:delivery/screens/previous_orders.dart';
import 'package:delivery/screens/price_page.dart';
import 'package:delivery/screens/profile_screen.dart';
import 'package:delivery/screens/log_in.dart';
import 'package:delivery/screens/map_sceaan.dart';
import 'package:delivery/screens/otp_screen.dart';
import 'package:delivery/screens/edit_profile_screen.dart';
import 'package:delivery/screens/rate_customer_screen.dart';
import 'package:delivery/screens/rate_driver_screen.dart';
import 'package:delivery/screens/receive_prices.dart';
import 'package:delivery/screens/registration_screen.dart';
import 'package:delivery/screens/reset_pw_screen.dart';
import 'package:delivery/screens/sign_up.dart';
import 'package:delivery/screens/type_order_screen.dart';
import 'package:delivery/shared/app.dart';
import 'package:delivery/shared/app2.dart';
import 'package:delivery/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'shared/button_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await UserPrefernces.init;

  runApp(const MyApp());
  //runApp(const App());
  //runApp(const App2());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AOU'er Delivery",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: const ProfileScreen(),
      // home: const Auth(),
      initialRoute: ReceivePricesScreen.screenRoute,
      routes: {
        WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
        RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
        SignUpScreen.screenRoute: (context) => SignUpScreen(),
        loginScreen.screenRoute: (context) => loginScreen(),
        MapScreen.screenRoute: (context) => MapScreen(),
        ResetScreen.screenRoute: (context) => ResetScreen(),
        ProfileScreen.screenRoute: (context) => ProfileScreen(),
        OTPScreen.screenRoute: (context) => OTPScreen(),
        EditProfileScreen.screenRoute: (context) => EditProfileScreen(
              userType: '',
            ),
        TypeOrder.screenRoute: (context) => TypeOrder(),
        RateScreen.screenRoute: (context) => RateScreen(),
        ReceiveOrderPage.screenRoute: (context) => ReceiveOrderPage(),
        ReceivePricesScreen.screenRoute: (context) => ReceivePricesScreen(),
        PreviousOrdersScreen.screenRoute: (context) => PreviousOrdersScreen(),
        RateCustomerScreen.screenRoute: (context) => RateCustomerScreen(),
        App.screenRoute: (context) => App(),
        App2.screenRoute: (context) => App2(),
      },
    );
  }
}

