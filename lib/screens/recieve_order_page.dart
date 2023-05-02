import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constract/color_string.dart';
import 'customer_info.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'map_sceaan.dart';
import 'registration_screen.dart';

var driverDoc;
var driverData;

class Driver {
  final String name;
  final String photoUrl;

  const Driver(this.name, this.photoUrl);
}

class ReceiveOrderPage extends StatefulWidget {
  static const String screenRoute = 'price_page';
  const ReceiveOrderPage({super.key});

  @override
  _ReceiveOrderPageState createState() => _ReceiveOrderPageState();
}

class _ReceiveOrderPageState extends State<ReceiveOrderPage> {
  final user = FirebaseAuth.instance.currentUser!;

  String _deliveryPrice = '';

  getDriver(driver_id) async {
    driverDoc = FirebaseFirestore.instance.collection('drivers').doc(driver_id);
    DocumentSnapshot doc = await driverDoc.get();
    if (doc.exists) {
      // access the data here
      driverData = doc.data();
      mPrint('user data ${driverData}');
    } else {
      mPrint('no data found');
    }
    return driverData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AOUbackground,
      appBar: AppBar(
        backgroundColor: AOUAppBar,
        title: Text('Receive Order'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            FutureBuilder<dynamic>(
              future: getDriver(user.uid),
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
                      accountEmail: Text(snapshot.data?['email']),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data?['profilePic']),
                        radius: 30,
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
                Icons.contact_mail,
                size: 30,
              ),
              title: Text(
                "Contact us",
                style: TextStyle(fontSize: 15),
              ),
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'support@aouer.com',
                  queryParameters: {
                    'subject': 'Support Request',
                    'body': 'Please describe your issue or question here.',
                  },
                );
                if (await canLaunch(emailLaunchUri.toString())) {
                  await launch(emailLaunchUri.toString());
                } else {
                  throw 'Could not launch $emailLaunchUri';
                }
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

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Customer Information',
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            order['customer name'] ?? '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            order['customer phone no'] ?? '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(children: [
                                        Icon(
                                          Icons.email,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          order['customer email'] ?? '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Close'))
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            'Show Customer Information',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              order['order'] ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Delivery Location: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  String googleUrl =
                                      'https://www.google.com/maps/search/?api=1&query=${order['location']['latitude']},${order['location']['longitude']}';

                                  await launchUrlString(googleUrl,
                                      mode: LaunchMode.externalApplication);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
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
                            },
                            child: Text('Send Delivery Price'),
                          ),
                        SizedBox(height: 40),
                      ],
                    ),
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
