import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/color_string.dart';
import 'package:delivery/screens/chat/driver_chat_screen.dart';
import 'package:delivery/screens/rate_customer_screen.dart';
import 'package:delivery/screens/rate_driver_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constract/image_string.dart';
import 'style.dart';

class CustomerInfo extends StatefulWidget {
  static const String screenRoute = 'customer_info';
  String? customerId;
  String? orderId;

  CustomerInfo({this.customerId, this.orderId});

  // ContInfo({ this.driverId});

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  var userData;
  String? bilPic;
  bool isLoading = false;

  getCustomerData() async {
    setState(() {
      isLoading = true;
    });

    print('customer id ${widget.customerId}');
    final userDoc = await FirebaseFirestore.instance
        .collection('customers')
        .doc(widget.customerId);
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

    return userData;
  }

  @override
  void initState() {
    super.initState();
  }

  String? downloadUrl;

  Future<String?> uploadImage(File filepath, String? reference) async {
    try {
      final finalName =
          '${FirebaseFirestore.instance.collection('orders').doc(widget.orderId)}${DateTime.now().second}';
      final Reference fbStorage =
          FirebaseStorage.instance.ref(reference).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadUrl = await fbStorage.getDownloadURL();
      });

      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  updateOrder() {
    var collectionRef = FirebaseFirestore.instance.collection('orders');
    var documentRef = collectionRef.doc(widget.orderId);
    print('image: ${downloadUrl}');
    uploadImage(File(bilPic!), 'order').whenComplete(
      () => documentRef.update({
        'bilPic': downloadUrl.toString(),
      }),
    );
    // print('id :: ${widget.orderId}');
    // print('id :: ${bilPic}');
    // FirebaseFirestore.instance.collection('orders').doc(widget.orderId).update({
    //   'bilPic': bilPic,
    // }).then((value) {
    //   print('Order updated successfully');
    // }).catchError((error) {
    //   print('Failed to update order: $error');
    // });
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
      body: FutureBuilder(
          future: getCustomerData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      height: 40,
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
                                    builder: (context) => DriverChatScreen(
                                      orderId: widget.orderId ?? '',
                                    ),
                                  ),
                                );
                                // Navigate to chat screen
                              },
                              child:
                                  Text("Chat", style: TextStyle(fontSize: 20)),
                            ),
                          ]),
                          SizedBox(
                            height: 50,
                          ),
                          Row(children: [
                            Icon(Icons.receipt_long, size: 40),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: () async {
                                final XFile? pickImage = await ImagePicker()
                                    .pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50);
                                print('orderid :: ${widget.orderId}');

                                if (pickImage != null) {
                                  setState(() {
                                    bilPic = pickImage.path.trim();
                                  });
                                }
                              },
                              child: Text("take a picture of the bill",
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ]),
                          // SizedBox(height: 5),
                          // Container(
                          //   child: bilPic == null
                          //       ? CircleAvatar(
                          //     radius: 70,
                          //     backgroundColor: Colors.grey,
                          //     child: Image.asset(
                          //       AOUlogo,
                          //       height: 80,
                          //       width: 80,
                          //     ),
                          //   )
                          //       : CircleAvatar(
                          //     radius: 70,
                          //     backgroundImage: FileImage(File(bilPic!)),
                          //   ),
                          // ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              updateOrder();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RateCustomerScreen(
                                      customerId: 'customerId'),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 130,
                              color: Colors.black,
                              child: Center(
                                  child: Text(
                                'Rate the customer',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
          }),
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
              '$title:\n \t $value',
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
