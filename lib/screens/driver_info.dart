// app.dart

import 'package:delivery/constract/color_string.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'style.dart';

class DrivInfo extends StatelessWidget {
  static const String screenRoute = 'driver_info';

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
            Text(
              'Contact information',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: AOUbackground,
                  child: Image.asset(
                    'lib/shared/widgets/assets/img_452264.png',
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
                    value: 'Ahmed',
                  ),
                  _buildContactItem(
                    icon: Icons.phone,
                    title: 'Phone Number',
                    value: '0507652341',
                  ),
                  Row(children: [
                    Icon(Icons.chat_outlined, size: 40),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
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
                        // Navigate to chat screen
                      },
                      child: Text("take a picture of the bill",
                          style: TextStyle(fontSize: 20)),
                    ),
                  ]),
                ],
              ),
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
