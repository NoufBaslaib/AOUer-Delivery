import 'package:flutter/material.dart';

class WatermarkBackground extends StatelessWidget {
  final Widget child;
  final String imagePath;

  const WatermarkBackground({Key? key, required this.child, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
