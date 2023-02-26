//import 'package:animated_card_input/shared/interfaces/orientation.interface.dart';
//import 'package:animated_card_input/shared/widgets/spacing.widget.dart';
import 'package:delivery/shared/interfaces/orientation.interface.dart';
import 'package:delivery/shared/widgets/spacing.widget.dart';
import 'package:flutter/material.dart';

OrientationType orientationType = OrientationType();

Widget ccv(BuildContext context, ValueNotifier<String> ccvNumber) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 100,
    height: 50,
    child: Container(
      color: Color.fromARGB(255, 188, 179, 179),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('CCV', style: TextStyle(fontSize: 15)),
          xsSpacing(orientationType.Horizontal),
          ValueListenableBuilder<String>(
              valueListenable: ccvNumber,
              builder:
                  (BuildContext context, String ccvNumberNew, Widget? first) {
                return SizedBox(
                  width: 60,
                  child:
                      Text(ccvNumberNew, style: const TextStyle(fontSize: 20)),
                );
              })
        ],
      ),
    ),
  );
}
