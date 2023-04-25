import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constract/color_string.dart';
import 'customer_info.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'map_sceaan.dart';

class ReceiveOrderPage extends StatefulWidget {
  static const String screenRoute = 'price_page';
  const ReceiveOrderPage({super.key});

  @override
  _ReceiveOrderPageState createState() => _ReceiveOrderPageState();
}

class _ReceiveOrderPageState extends State<ReceiveOrderPage> {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _deliveryPrice = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AOUbackground,
      appBar: AppBar(
        backgroundColor: AOUAppBar,
        leading: IconButton(
          onPressed: () {
            // Navigator.pushNamed(context, SignUpScreen.screenRoute);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => MapScreen()));
          },
          icon: const Icon(LineAwesomeIcons.arrow_circle_left),
        ),
        title: Text('Receive Order'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return getLoading();

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var order =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Name : \t',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            order['customer name'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'phoneNumber : ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            order['customer phone no'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Email : ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            order['customer email'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Order : ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            order['order'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Location: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                String googleUrl =
                                    'https://www.google.com/maps/search/?api=1&query=${order['location']['latitude']},${order['location']['longitude']}';

                                await launchUrlString(googleUrl,
                                    mode: LaunchMode.externalApplication);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AOUAppBar,
                              ),
                              child: Text('open'))
                        ],
                      ),

                      Form(
                        // key: formKey,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Delivery Price',
                          ),

                          onChanged: (value) {
                            setState(() {
                              _deliveryPrice = value;
                            });
                          },
                          // onSaved: (value) => _deliveryPrice = value,
                        ),
                      ),
                      if (order['isAccepted'] &&
                          order['driverId'] ==
                              FirebaseAuth.instance.currentUser?.uid)
                        MaterialButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CustomerInfo(
                                    customerId: order['customerId'],
                                    orderId: order['order id']),
                              ),
                            );
                          },
                          child: Text('Show customer information'),
                        )
                      else
                        MaterialButton(
                          onPressed: () async {
                            if (_deliveryPrice.trim().isEmpty) return;
                            // await FirebaseFirestore.instance
                            //     .collection('orders')
                            //     .doc(snapshot.data!.docs[index].id)
                            //     .update({
                            //   'driverId': FirebaseAuth.instance.currentUser!.uid
                            // });
                            await FirebaseFirestore.instance
                                .collection('orders')
                                .doc(snapshot.data!.docs[index].id)
                                .collection('offerPrices')
                                .add({
                              'price': _deliveryPrice,
                              'isAccepted': false,
                              'driverId':
                                  FirebaseAuth.instance.currentUser!.uid,
                            });

                            FlutterToastr.show("Price Sent", context);
                            // order['isAccepted'] == false
                            //     ? ''
                            //     : Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (_) => CustomerInfo(
                            //               customerId: order['customerId'],
                            //               orderId: order['order id']),
                            //         ),
                            //       );
                            // Scaffold.of(context).showBodyScrim(false, opacity)
                          },
                          child: Text('Send Delivery Price'),
                        ),
                      SizedBox(height: 40),
                      // MaterialButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (_) =>
                      //             CustomerInfo(customerId: order['customerId'],orderId: order['order id']),
                      //       ),
                      //     );
                      //     // Scaffold.of(context).showBodyScrim(false, opacity)
                      //   },
                      //   child: Text('Customer details'),
                      // ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
