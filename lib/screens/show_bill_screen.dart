import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowBillScreen extends StatefulWidget {
  String? orderId;

  ShowBillScreen({this.orderId});

  @override
  State<ShowBillScreen> createState() => _ShowBillScreenState();
}

class _ShowBillScreenState extends State<ShowBillScreen> {
  bool isLoading = false;
  var userData;

  getOrderData() async {
    isLoading = true;
    setState(() {});

    print('user ID ${widget.orderId}');
    final userDoc = await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.orderId);
    userDoc.get().then((doc) {
      if (doc.exists) {
        userData = doc.data();
        setState(() {});
// print('user data ${userData['name']}');
      } else {
        // handle non-existent document here
      }
    });

    
    setState(() {isLoading = false;});
  }

  void initState() {
    super.initState();
    getOrderData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: userData != null
                    ? Image.network(
                        userData?['bilPic'] ?? "",
                        fit: BoxFit.cover,
                        height: 300,
                        width: 300,
                      )
                    : Center(
                        child: Text('Nothing to show here'),
                      ),
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 80,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'back',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
