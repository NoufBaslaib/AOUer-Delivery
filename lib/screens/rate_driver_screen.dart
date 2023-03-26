import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constract/color_string.dart';
import 'package:delivery/constract/helpers.dart';
import 'package:delivery/screens/type_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constract/image_string.dart';

class RateDriverScreen extends StatefulWidget {
  static const screenRoute = 'rate_driver_screen';

  const RateDriverScreen({super.key, required this.driverID});

  final String driverID;

  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
  double rating = 0;

  Widget buildRating() => RatingBar.builder(
        initialRating: rating,
        minRating: 1,
        itemSize: 46,
        itemPadding: EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        updateOnDrag: true,
        onRatingUpdate: ((rating) => setState(() {
              this.rating = rating;
            })),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AOUbackground,
      appBar: AppBar(
        backgroundColor: AOUAppBar,
        leading: IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
        title: const Text('Rate Driver', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 180,
              child: Image.asset(AOUlogo),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline_sharp,
                        size: 50.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Your order has been arrived',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'please rate the driver: $rating',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildRating(),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () async {
                      var driver = await FirebaseFirestore.instance.collection('drivers').get().then((QuerySnapshot snapshot) {
                        //Here we get the document reference and return to the post variable.
                        mPrint("DOCS ${snapshot.docs}");
                        return snapshot.docs[0].reference;
                      });
                      var batch = await driver.collection('ratings').add({
                        'ratedBy': widget.driverID,
                        'rating': rating.toString(),
                      });

                      FlutterToastr.show("Rating added successfully", context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TypeOrder(name: 'Name', phoneNumber: '03085098342')));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      child: Text(
                        'Submit Rating',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
