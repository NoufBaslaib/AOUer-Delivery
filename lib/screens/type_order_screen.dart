import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/auth/user_role.dart';
import 'package:delivery/screens/previous_orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constract/color_string.dart';
import '../constract/helpers.dart';
import '../model/global_key.dart';
import 'choose_location_screen.dart';
import 'map_sceaan.dart';
import 'receive_prices.dart';
import 'registration_screen.dart';

var customerDoc;
var customerData;

class Customer {
  final String name;
  final String photoUrl;

  const Customer(this.name, this.photoUrl);
}

class TypeOrder extends StatefulWidget {
  static const String screenRoute = 'type_order_screen';

  TypeOrder();

  String id = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  State<TypeOrder> createState() => _TypeOrderState();
}

class _TypeOrderState extends State<TypeOrder> {
  String? _orderDetails;
  final user = FirebaseAuth.instance.currentUser!;
  final formKey = GlobalKey<FormState>();

  // void _moreOptions(BuildContext ctx) {
  //   showModalBottomSheet(
  //       context: ctx,
  //       builder: (_) {
  //         return GestureDetector(
  //           onTap: () {},
  //           child: ,
  //           behavior: HitTestBehavior.opaque,
  //         );
  //       });
  // }

  getCustomer(id) async {
    customerDoc = FirebaseFirestore.instance.collection('customers').doc(id);
    DocumentSnapshot doc = await customerDoc.get();
    if (doc.exists) {
      // access the data here
      customerData = doc.data();
      mPrint('user data ${customerData}');
    } else {
      // handle non-existent document here
      mPrint('no data found');
    }
    return customerData;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: AOUbackground,
        appBar: AppBar(
          backgroundColor: AOUAppBar,
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, MapScreen.screenRoute);
          //     },
          //     icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
          title: Text('Order', style: Theme.of(context).textTheme.headline4),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              FutureBuilder<dynamic>(
                future: getCustomer(user.uid),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                    );
                  } else {
                    return Container(
                      child: UserAccountsDrawerHeader(
                        accountName: Text(
                          snapshot.data?['name'] ?? '',
                          style: TextStyle(fontSize: 20),
                        ),
                        accountEmail: Text(user.email!),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data?['profilePic']),
                          radius: 30,
                          // backgroundImage: NetworkImage(
                          //   snapshot.data?['profilePic']
                          // ),
                        ),
                        decoration: BoxDecoration(
                          color: AOUAppBar,
                        ),
                      ),
                    );
                  }
                }),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  size: 30,
                ),
                title: Text(
                  "Change location",
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleMapScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.history,
                  size: 30,
                ),
                title: Text(
                  "View existing orders",
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviousOrdersScreen()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 30,
                ),
                title: Text(
                  "Sign out",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => RegistrationScreen()));
                },
              ),
            ],
          ),
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
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              var user = await FirebaseFirestore.instance
                                  .collection('customers')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get();
                              var order = {
                                'order id': widget.id,
                                'customerId': user['id'],
                                'driverId': '',
                                'bilPic': '',
                                'isAccepted': false,
                                'customer name': user['name'],
                                'customer phone no': user['phone'],
                                'customer email': user['email'],
                                'order': _orderDetails,
                                'deliveryPrice': '',
                                'location': user['location']
                              };
                              sendOrderToDriver(order);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ReceivePricesScreen(order: order),
                                ),
                              );
                            }
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
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // SizedBox(
                      //   width: 200,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => GoogleMapScreen(),
                      //         ),
                      //       );
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: AOUAppBar,
                      //         side: BorderSide.none,
                      //         shape: const StadiumBorder()),
                      //     child: const Text(
                      //       'Change Location',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // SizedBox(
                      //   width: 200,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) =>
                      //                   PreviousOrdersScreen()));
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.black,
                      //         side: BorderSide.none,
                      //         shape: const StadiumBorder()),
                      //     child: const Text(
                      //       'View Existing Orders',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendOrderToDriver(Map<String, dynamic> order) async {
    final DocumentReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('orders').doc(widget.id);
    if (_orderDetails == null) {
      print('type your order first');
    } else {
      await collection.set(order);
    }
  }
}
