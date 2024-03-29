import 'package:flutter/material.dart';

Widget chipImg() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SizedBox(
          width: 80,
          height: 50,
          child: Image.asset('lib/shared/widgets/assets/chip.png',
              color: Colors.black),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: SizedBox(
          width: 70,
          child: Image.asset('lib/shared/widgets/assets/visacard.png',
              color: Colors.black),
        ),
      )
    ],
  );
}
