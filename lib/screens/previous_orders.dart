import 'package:delivery/constract/color_string.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PreviousOrdersScreen extends StatelessWidget {
  static const screenRoute = 'previous_orders';
  final List<String> previousOrders = ['apple', 'books', 'burger', 'coffee'];

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
        title: Text('Previous Orders'),
      ),
      body: ListView.builder(
        itemCount: previousOrders.length,
        itemBuilder: (context, index) {
          final order = previousOrders[index];
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15)),
                width: 350,
                child: ListTile(
                  title: Text(
                    order,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Montserrat'),
                  ),
                  leading: Icon(Icons.shopping_cart),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
