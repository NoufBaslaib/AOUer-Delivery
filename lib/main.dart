import 'auth/auth_page.dart';
import 'screens/customer_info.dart';
import 'screens/driver_Info.dart';
import 'screens/previous_orders.dart';
import 'screens/recieve_order_page.dart';
import 'screens/profile_screen.dart';
import 'screens/log_in.dart';
import 'screens/map_sceaan.dart';
import 'screens/otp_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/rate_customer_screen.dart';
import 'screens/rate_driver_screen.dart';
import 'screens/receive_prices.dart';
import 'screens/registration_screen.dart';
import 'screens/reset_pw_screen.dart';
import 'screens/sign_up.dart';
import 'screens/type_order_screen.dart';
import 'shared/app.dart';
import 'shared/app2.dart';
import 'utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        primarySwatch: Colors.blue,
      ),
      //home: const ProfileScreen(),
      // home: MapScreen(),
      home: const Auth(),
      // initialRoute: PreviousOrdersScreen.screenRoute,
      routes: {
        RegistrationScreen.screenRoute: (context) => RegistrationScreen(),
        SignUpScreen.screenRoute: (context) => SignUpScreen(),
        LoginScreen.screenRoute: (context) => LoginScreen(),
        MapScreen.screenRoute: (context) => MapScreen(),
        ResetScreen.screenRoute: (context) => ResetScreen(),
        ProfileScreen.screenRoute: (context) => ProfileScreen(),
        OTPScreen.screenRoute: (context) => OTPScreen(),
        EditProfileScreen.screenRoute: (context) =>
            EditProfileScreen(userType: ''),
        TypeOrder.screenRoute: (context) =>
            TypeOrder(name: '', phoneNumber: ''),
        ReceiveOrderPage.screenRoute: (context) => ReceiveOrderPage(),
        ReceivePricesScreen.screenRoute: (context) =>
            ReceivePricesScreen(order: {}),
        PreviousOrdersScreen.screenRoute: (context) => PreviousOrdersScreen(),
        RateCustomerScreen.screenRoute: (context) =>
            RateCustomerScreen(customerId: ''),
        CreditScreen.screenRoute: (context) => CreditScreen(),
        PaymentScreen.screenRoute: (context) => PaymentScreen(),
        DriverInfo.screenRoute: (context) => DriverInfo(),
        CustomerInfo.screenRoute: (context) => CustomerInfo(),
      },
    );
  }
}
