import 'package:delivery/shared/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'package:delivery/main.dart';

class ButtonController extends GetxController {
  //static const String screenRoute = 'button_controller';

  String _orderType = 'credit_card';

  var screenRoute;

  String get orderType => _orderType;
  void setOrderType(String type) {
    _orderType = type;
    print("The order type is " + _orderType);
    update();
  }
}
