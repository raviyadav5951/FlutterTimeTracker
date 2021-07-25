import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final double borderRadius;
  final double height;

  CustomElevatedButton(
      {Key key,
      this.child,
      this.color = Colors.white,
      this.onPressed,
      this.borderRadius: 4.0,
      this.height = 50.0})
      : assert(borderRadius != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return color; // Disabled color
            }
            return color; // Regular color
          }),
        ),
      ),
    );
  }
}
