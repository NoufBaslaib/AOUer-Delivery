import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../constract/color_string.dart';
import '../constract/image_string.dart';
import 'choose_location_screen.dart';
import 'map_sceaan.dart';
import 'recieve_order_page.dart';

class RateCustomerScreen extends StatefulWidget {
  static const screenRoute = 'rate_customer_screen';

  final String customerId;

  const RateCustomerScreen({required this.customerId});

  @override
  State<RateCustomerScreen> createState() => _RateCustomerScreenState();
}

class _RateCustomerScreenState extends State<RateCustomerScreen> {
  double customerRating = 0;

  Widget buildRating() => RatingBar.builder(
        initialRating: customerRating,
        minRating: 1,
        itemSize: 46,
        itemPadding: EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        updateOnDrag: true,
        onRatingUpdate: ((rating) => setState(() {
              customerRating = rating;
            })),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AOUbackground,
      appBar: AppBar(
        backgroundColor: AOUAppBar,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => GoogleMapScreen()));
            },
            icon: const Icon(LineAwesomeIcons.arrow_circle_left)),
        title: const Text('Rate Customer', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                            'Thank You',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'please rate the customer: $customerRating',
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
                        // Get a reference to the "customer" collection
                        var collectionRef = FirebaseFirestore.instance.collection('customers').doc(widget.customerId).collection('ratings').add({
                          'ratedBy': FirebaseAuth.instance.currentUser!.uid,
                          'rating': customerRating.toString(),
                        });

                        // Show a snackbar to indicate that the rating was submitted successfully
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Rating submitted successfully!')),
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiveOrderPage()));
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
                    // ElevatedButton(
                    //   style:
                    //       ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    //   onPressed: () {
                    //     var collectionRef = FirebaseFirestore.instance.collection('customer');
                    //     var documentId = FirebaseAuth.instance.currentUser!.uid;
                    //     var documentRef = collectionRef.doc(documentId);
                    //       documentRef.update({
                    //         'rating' : customerRating,
                    //       });
                    //   },
                    //   child: const Padding(
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    //     child: Text(
                    //       'Submit Rating',
                    //       style: TextStyle(
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
