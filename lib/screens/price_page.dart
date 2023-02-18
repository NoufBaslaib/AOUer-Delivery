import 'package:delivery/constract/color_string.dart';
import 'package:delivery/model/global_key.dart';
import 'package:delivery/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ReceiveOrderPage extends StatefulWidget {
  static const String screenRoute = 'price_page';
  @override
  _ReceiveOrderPageState createState() => _ReceiveOrderPageState();
}

class _ReceiveOrderPageState extends State<ReceiveOrderPage> {
  String? _orderDetails;
  String? _deliveryPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AOUbackground,
      appBar: AppBar(
        backgroundColor: AOUAppBar,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SignUpScreen.screenRoute);
          },
          icon: const Icon(LineAwesomeIcons.arrow_circle_left),
        ),
        title: Text('Receive Order'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot order = snapshot.data!.docs[index];
                    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
                    return Center(
                      child: Container(
                        width: 350,
                        //padding: EdgeInsets.all(3),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          shadowColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Order Details'),
                                            content: Text(
                                              order['orderDetails'],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('close'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Text(
                                    'order details',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Customer information'),
                                            content:
                                                Text('customer informaion'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('close'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Text('Customer Informaion',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Location'),
                                            content: Text('Location'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('close'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Text('Location',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Form(
                                  key: formKey,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Delivery Price',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a delivery price';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) => _deliveryPrice = value,
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      sendDeliveryPrice(order.id);
                                    }
                                  },
                                  child: Text('Send Delivery Price'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void sendDeliveryPrice(String orderId) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'deliveryPrice': _deliveryPrice});
  }
}
