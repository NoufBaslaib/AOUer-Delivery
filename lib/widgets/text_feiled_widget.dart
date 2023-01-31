
import 'package:flutter/material.dart';

class FillTextWidget extends StatelessWidget {
  const FillTextWidget({Key? key, required this.title, required this.icon, required this.onChanged})
      : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      onChanged: ((value) {}),
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: title,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
