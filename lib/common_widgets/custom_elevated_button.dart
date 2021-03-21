import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final ui.VoidCallback onPressed;
  final double borderRadius;
  final double height;

  CustomElevatedButton(
      {this.child,
      this.color = Colors.white,
      this.onPressed,
      this.borderRadius: 4.0,
      this.height = 50.0}):assert(borderRadius!=null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: () {},
        child: child,
        style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            )),
      ),
    );
  }
}
