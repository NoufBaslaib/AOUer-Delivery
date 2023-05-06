// app.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/color_string.dart';
import 'package:delivery/screens/rate_driver_screen.dart';
import 'package:delivery/screens/show_bill_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'chat/customer_chat_screen.dart';
import 'style.dart';

class DriverInfo extends StatefulWidget {
  String? driverId;
  String? orderId;

  DriverInfo({this.driverId, this.orderId});

  static const String screenRoute = 'driver_info';

  @override
  State<DriverInfo> createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  var userData;
  bool isLoading = false;

  getCustomerData() async {
    setState(() {
      isLoading = true;
    });

    print('user ID ${widget.driverId}');
    final userDoc = await FirebaseFirestore.instance
        .collection('drivers')
        .doc(widget.driverId);
    userDoc.get().then((doc) {
      if (doc.exists) {
        // access the data here
        userData = doc.data();
        setState(() {});
        print('user data ${userData}');
      } else {
        // handle non-existent document here
        print('no data found');
      }
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCustomerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AOUbackground,
      appBar: AppBar(
        backgroundColor: AOUAppBar,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.arrow_circle_left),
        ),
        title: Text(
          'Contact information',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: AOUbackground,
                  child: Image.network(
                    userData?['profilePic'] ?? "",
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildContactItem(
                    icon: Icons.person,
                    title: 'Name',
                    value: userData?['name'] ?? "",
                  ),
                  _buildContactItem(
                    icon: Icons.phone,
                    title: 'Phone Number',
                    value: userData?['phone'] ?? "",
                  ),
                  Row(children: [
                    Icon(Icons.chat_outlined, size: 40),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerChatScreen(
                              orderId: widget.orderId ?? '',
                            ),
                          ),
                        );
                        // Navigate to chat screen
                      },
                      child: Text("Chat", style: TextStyle(fontSize: 20)),
                    ),
                  ]),
                  SizedBox(
                    height: 50,
                  ),
                  Row(children: [
                    Icon(Icons.receipt_long, size: 40),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowBillScreen(
                              orderId: widget.orderId,
                            ),
                          ),
                        );
                      },
                      child:
                          Text("Show the bill", style: TextStyle(fontSize: 20)),
                    ),
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RateDriverScreen(driverID: 'driverId'),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      color: Colors.black,
                      child: Center(
                          child: Text(
                        'Rate the driver',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    IconData? icon,
    required String title,
    String? value,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(width: 8),
            Text(
              '$title: $value',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
