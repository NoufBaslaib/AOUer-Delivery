import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/components/home.component.dart';
import 'package:delivery/constract/color_string.dart';
import 'package:delivery/screens/type_order_screen.dart';
import 'package:delivery/screens/driver_Info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constract/helpers.dart';

var driverDoc;
var driverData;

class Price {
  final int value;

  const Price(this.value);
}

class Driver {
  final String name;
  final String photoUrl;
  final double rating;

  const Driver(this.name, this.photoUrl, this.rating);
}

class ReceivePricesScreen extends StatelessWidget {
  static const String screenRoute = 'receive_price';

  ReceivePricesScreen({Key? key, required this.order}) : super(key: key);

  final Map<String, dynamic> order;

  Future<Map<String, dynamic>> getDriverD(driver_id) async {
    driverDoc = FirebaseFirestore.instance.collection('drivers').doc(driver_id);
    DocumentSnapshot doc = await driverDoc.get();
    if (doc.exists) {
      // access the data here
      driverData = doc.data();
      mPrint('user data ${driverData}');
    } else {
      // handle non-existent document here
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
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, TypeOrder.screenRoute);
          },
          icon: const Icon(LineAwesomeIcons.arrow_circle_left),
        ),
        title: const Text('Prices'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(order['order id'])
              .collection('offerPrices')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            mPrint("Order :: ${order}");

            return snapshot.data!.docs.length == 0
                ? Center(
                    child: Text("No Prices received"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      final offer = snapshot.data!.docs[index].data();

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\SR${snapshot.data!.docs[index].data()["price"]}',
                                        style: const TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      !snapshot.data!.docs[index]
                                              .data()['isAccepted']
                                          ? Row(
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  167,
                                                                  129,
                                                                  162)),
                                                  onPressed: () {
                                                    // Accept button action
                                                    FirebaseFirestore.instance
                                                        .collection('orders')
                                                        .doc(order['order id'])
                                                        .collection(
                                                            'offerPrices')
                                                        .doc(snapshot.data!
                                                            .docs[index].id)
                                                        .update(
                                                      {
                                                        'isAccepted': true,
                                                      },
                                                    );
                                                    FirebaseFirestore.instance
                                                        .collection('orders')
                                                        .doc(order['order id'])
                                                        .update(
                                                      {
                                                        'isAccepted': true,
                                                        'driverId':
                                                            offer["driverId"],
                                                      },
                                                    );
                                                    FlutterToastr.show(
                                                        'Order accepted.',
                                                        context);
                                                    print(
                                                        'receive price ${offer['price']}');
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            height: 150,
                                                            child: Column(
                                                                children: [
                                                                  ListTile(
                                                                    title: Text(
                                                                        'Cash'),
                                                                    onTap: () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (_) =>
                                                                              MyHomePage(
                                                                            title:
                                                                                '',
                                                                          ),
                                                                        ),
                                                                      ).then(
                                                                          (result) {
                                                                        if (result !=
                                                                            null) {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (_) => DriverInfo(
                                                                                driverId: result['driverId'],
                                                                                orderId: result['orderId'],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                      });
                                                                    },
                                                                  ),
                                                                  ListTile(
                                                                    title: Text(
                                                                        'Credit Card'),
                                                                    onTap: () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (_) =>
                                                                              MyHomePage(
                                                                            driverId:
                                                                                offer['driverId'],
                                                                            orderId:
                                                                                order['order id'],
                                                                            title:
                                                                                '',
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  )
                                                                ]),
                                                          );
                                                        });
                                                  },
                                                  child: const Text('Accept'),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.grey),
                                                  onPressed: () {
                                                    // Decline button action
                                                    FirebaseFirestore.instance
                                                        .collection('orders')
                                                        .doc(order['id'])
                                                        .collection(
                                                            'offerPrices')
                                                        .doc(snapshot.data!
                                                            .docs[index].id)
                                                        .delete();
                                                  },
                                                  child: const Text('Decline'),
                                                ),
                                              ],
                                            )
                                          : Text("Accepted"),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  FutureBuilder<Map<String, dynamic>>(
                                    future: getDriverD(offer["driverId"]),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Map<String, dynamic>>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => DriverInfo(
                                                        driverId:
                                                            offer['driverId'],
                                                        orderId:
                                                            order['order id']),
                                                  ),
                                                );
                                              },
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot
                                                        .data?['profilePic']),
                                                radius: 30,
                                              ),
                                            ),
                                            const SizedBox(width: 16.0),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data?['name'] ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 20.0,
                                                      color: Colors.amber,
                                                    ),
                                                    Text(
                                                        '${snapshot.data?['rating']}...'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
