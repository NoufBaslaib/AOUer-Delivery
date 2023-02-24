import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  static const String screenRoute = 'my_button';

  MyButton({required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: Color.fromARGB(255, 164, 162, 162),
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: onPressed,
          // Navigator.pushNamed(context, FromCardInput.screenRoute);

          minWidth: 200,
          height: 42,
          child: Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
