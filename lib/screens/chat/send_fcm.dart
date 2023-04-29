import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<void> sendPushMessage(String body, String title, String token) async {
  try {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    var user = await FirebaseFirestore.instance
                                .collection('customers')
                                .doc(userID).get();
   var userName = '';
    if (user.exists) {
      user['name'];
    } else {
      
    }
    var resp = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAApklJ59I:APA91bF_ohzf-bDS8TBWep83Z9iRCZ6owO6EDnSc6-A4KlpO9FtHZcZPvWfVhutvj4Lod6wh_dGjVpHate2i_jPZb0CymLK8Z9QixMqWfG8XQ1cgNnhkj5HzVVh0zX8q6nHmiDqM827l',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body,
            'title': title,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          "to": token,
        },
      ),
    );
    print('done');
    print(resp);
  } catch (e) {
    print("error push notification");
  }
}
