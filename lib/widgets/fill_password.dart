import 'package:delivery/constract/color_string.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField(
      {Key? key,
      required this.title,
      required this.icon,
      required this.obscureText, required Null Function(dynamic value) onChanged, 
      //required this.onChanged
      })
      : super(key: key);
  final IconData icon;
  final String title;
  //final VoidCallback onChanged;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      textAlign: TextAlign.center,
      //onChanged: ((value) {}),
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
