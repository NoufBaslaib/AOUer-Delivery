import 'package:delivery/constract/color_string.dart';
import 'package:delivery/screens/type_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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

final List<Price> prices = [
  Price(5),
  Price(20),
  Price(30),
  Price(50),
];

final List<Driver> drivers = [
  Driver('John Doe', 'https://via.placeholder.com/150', 4.5),
  Driver('Jane Smith', 'https://via.placeholder.com/150', 4.8),
  Driver('Bob Johnson', 'https://via.placeholder.com/150', 4.2),
];

class ReceivePricesScreen extends StatelessWidget {
  static const String screenRoute = 'receive_price';
  const ReceivePricesScreen({Key? key}) : super(key: key);

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
      body: ListView.builder(
        itemCount: prices.length,
        itemBuilder: (context, index) {
          final price = prices[index];
          final driver = drivers[index % drivers.length];
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${price.value}',
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 167, 129, 162)),
                                onPressed: () {
                                  // Accept button action
                                },
                                child: const Text('Accept'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey),
                                onPressed: () {
                                  // Decline button action
                                },
                                child: const Text('Decline'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(driver.photoUrl),
                            radius: 30,
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                driver.name,
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 20.0,
                                    color: Colors.amber,
                                  ),
                                  Text(driver.rating.toStringAsFixed(1)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
