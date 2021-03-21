import 'package:new_timetracker/common_widgets/custom_elevated_button.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SignInButton extends CustomElevatedButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    ui.VoidCallback onPressed,
  })  : assert(text != null),
        super(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15.0),
            ),
            color: color,
            onPressed: onPressed,
            height: 50.0);
}
