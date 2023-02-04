import 'dart:convert';

import 'package:delivery/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefernces {
  static late SharedPreferences _preferenced;

  static const _keyUser = 'user';
  static const myUser = User1(
      imagePath:
          'https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg',
      name: 'admin',
      email: 'admin@aou.edu.sa',
      phoneNumber: 'xxxx-xxxx-xx');

  static Future init() async =>
      _preferenced = await SharedPreferences.getInstance();

  static Future setUser(User1 user) async {
    final json = jsonEncode(user.toJson());

    await _preferenced.setString(_keyUser, json);
  }

  static User1 getUser() {
    final json = _preferenced.getString(_keyUser);

    return json == null ? myUser : User1.fromJson(jsonDecode(json));
  }
}
