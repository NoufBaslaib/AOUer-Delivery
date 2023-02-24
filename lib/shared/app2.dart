import 'package:delivery/constract/color_string.dart';
import 'package:delivery/shared/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

//import 'package:aou_app/app2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
//import 'package:aou_app/form_card_input_component';
import 'button_controller.dart';
import 'package:delivery/shared/my_button2.dart';

/*void main() {
  runApp(const MyApp());
  //runApp(const MyApp2());
}*/

/*void main() {
  runApp(const MyApp());
}*/
//form_card_input_component
class App2 extends StatelessWidget {
  static const String screenRoute = 'app2';
  const App2({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(ButtonController());
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          backgroundColor: AOUbackground,
          appBar: AppBar(
            backgroundColor: AOUAppBar,
            title: const Text('Payment'),
          ),
          body: SizedBox(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Choose payment method:",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45)),
                OrderTypeButton(
                    //Text("choose",style: TextStyle(fontSize: 50,color: Colors.white),)
                    value: "cash 💸 ",
                    title: "cach 💸 ",
                    amount: 10,
                    isFree: true),
                OrderTypeButton(
                    value: "credit card 💳",
                    title: "credit card 💳",
                    amount: 10,
                    isFree: false)
              ],
            ),
          ),
        ));
  }
}

class OrderTypeButton extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  const OrderTypeButton(
      {required this.value,
      required this.title,
      required this.amount,
      required this.isFree});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtonController>(
      builder: (buttonController) {
        //  var materialButton2 = MaterialButton(
//onPressed:  Navigator.pushNamed(context, ButtonController().screenRoute);,
//minWidth: 200,
//height: 42,
        child:
        Text(
          'Next',
          style: TextStyle(fontSize: 20, color: Colors.white),
//),
        );
        // var materialButton = materialButton2;
        return InkWell(
          onTap: () => buttonController.setOrderType(value),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: buttonController.orderType,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (String? value) {
                  //buttonController.setOrderType(value!);
                },
                activeColor: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                title,
              ),
              const SizedBox(width: 5),
              //Text(
              //'(${(value == 'take_away' || isFree) ? 'free' : amount != -1 ? '\$${amount / 10}' : 'calculating'})',
              // ),
              //MyButton(title: "credit card 💳", onPressed: Navigator.pushNamed(context, MyApp.screenRoute);)
              /*Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Material(
                  elevation: 5,
                  color: Color.fromARGB(255, 164, 162, 162),
                  borderRadius: BorderRadius.circular(10),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, App.screenRoute);
                    },
                    minWidth: 200,
                    height: 42,
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 20, color: Colors.white),*/
              //  ),
              // ),
              //),
              //),

//child: materialButton,
            ],
          ),
        );
      },
    );
  }
}
