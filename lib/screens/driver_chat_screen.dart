import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constract/color_string.dart';

class DriverChatScreen extends StatefulWidget {
  final String orderId;
  const DriverChatScreen({required this.orderId, super.key});

  @override
  State<DriverChatScreen> createState() => _DriverChatScreenState();
}

class _DriverChatScreenState extends State<DriverChatScreen> {
  final chatTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: AOUAppBar,
      ),
      backgroundColor: AOUbackground,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(widget.orderId)
              .collection('messages')
              .orderBy('id')
              .snapshots(),
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Expanded(
                  // height: (MediaQuery.of(context).size.height / 1.2),
                  child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: snapshot.data!.docs.length,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      final message = snapshot.data!.docs[index].data();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (message["sender"] == "driver"
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (message["sender"] == "driver"
                                    ? Colors.grey.shade200
                                    : Colors.blue[200]),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '${message["message"]}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black87),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: chatTextController,
                            style: const TextStyle(color: Colors.black54),
                            decoration: const InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            if (chatTextController.text.isEmpty) {
                              return;
                            }

                            FirebaseFirestore.instance
                                .collection('orders')
                                .doc(widget.orderId)
                                .collection('messages')
                                .add(
                              {
                                'message': chatTextController.text.trim(),
                                'sender': 'driver',
                                'id': snapshot.data!.docs.length + 1
                              },
                            );

                            chatTextController.clear();
                          },
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
