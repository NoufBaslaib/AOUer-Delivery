import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/color_string.dart';
import 'package:delivery/constract/image_string.dart';
import 'package:delivery/model/global_key.dart';
import 'package:delivery/screens/map_sceaan.dart';
import 'package:delivery/screens/price_page.dart';
//import 'package:delivery/screens/show_prices.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class TypeOrder extends StatefulWidget {
  static const String screenRoute = 'type_order_screen';
  const TypeOrder({super.key});

  @override
  State<TypeOrder> createState() => _TypeOrderState();
}

class _TypeOrderState extends State<TypeOrder> {
  //final _formKey1 = GlobalKey<FormState>();
  String? _orderDetails;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: JosKeys.JosKeys2,
      child: Scaffold(
        backgroundColor: AOUbackground,
        appBar: AppBar(
          backgroundColor: AOUAppBar,
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MapScreen.screenRoute);
              },
              icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
          title: Text('Order', style: Theme.of(context).textTheme.headline4),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        Text(
                          'please type your order:',
                          style: const TextStyle(
                            fontSize: (20.0),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'please type your order';
                            }
                            return null;
                          }),
                          onSaved: (value) => _orderDetails = value!,
                          decoration: InputDecoration(
                            hintText: 'Type your order here...',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          maxLines: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              if (JosKeys.JosKeys2.currentState!.validate()) {
                                JosKeys.JosKeys2.currentState!.save();
                                sendOrderToDriver();
                              }
                              Navigator.pushNamed(
                                  context, ReceiveOrderPage.screenRoute);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AOUAppBar,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: const Text(
                              'Send Order',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendOrderToDriver() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .add({'orderDetails': _orderDetails});
  }
}
