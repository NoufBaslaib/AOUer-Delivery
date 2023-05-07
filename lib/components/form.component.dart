/*import 'package:animated_card_input/components/form_cardholder_name_valid_thru_input.component.dart';
import 'package:animated_card_input/components/form_card_input.component.dart';
import 'package:animated_card_input/components/form_ccv_number_input.component.dart';
import 'package:animated_card_input/shared/interfaces/orientation.interface.dart';
import 'package:animated_card_input/shared/widgets/spacing.widget.dart';*/
import 'package:delivery/components/form_card_input.component.dart';
import 'package:delivery/components/form_cardholder_name_valid_thru_input.component.dart';
import 'package:delivery/components/form_ccv_number_input.component.dart';
import 'package:delivery/shared/interfaces/orientation.interface.dart';
import 'package:delivery/shared/widgets/spacing.widget.dart';
import 'package:flutter/material.dart';

import '../constract/color_string.dart';

OrientationType orientationType = OrientationType();

Widget form(
    TextEditingController cardNumberController,
    ValueNotifier<String> cardNumber,
    TextEditingController cardholderNameController,
    ValueNotifier<String> cardholderName,
    TextEditingController validThruController,
    ValueNotifier<String> validThru,
    TextEditingController ccvController,
    ValueNotifier<String> ccv,
    _flip,
    submition()) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Card(
      elevation: 3,
      child: Column(
        children: [
          mSpacing(orientationType.Vertical),
          cardTitle(_flip),
          sSpacing(orientationType.Vertical),
          Column(
            children: [
              /// CARD NUMBER INPUT FIELD
              cardNumberInput(cardNumberController, cardNumber),
              xsSpacing(orientationType.Vertical),

              /// CARDHOLDER NAME AND VALID THRU INPUT FIELDS cardholderNameValidThruInput
              cardholderNameValidThruInput(cardholderNameController,
                  cardholderName, validThruController, validThru),
              xsSpacing(orientationType.Vertical),

              /// CCV NUMBER
              ccvNumberInput(ccvController, ccv, _flip),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  submition();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AOUAppBar,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          mSpacing(orientationType.Vertical)
        ],
      ),
    ),
  );
}

Widget cardTitle(_flip) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const Text('Card Information', style: TextStyle(fontSize: 20)),
      xsSpacing(orientationType.Horizontal),
      GestureDetector(
        onTap: _flip,
        child: const Text('Flip card',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 211, 175, 175),
            )),
      ),
    ],
  );
}
