import 'package:new_timetracker/common_widgets/custom_elevated_button.dart';

import 'package:flutter/material.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    Key key,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          key:key,
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15.0),
            ),
            color: color,
            onPressed: onPressed,
            height: 50.0);
}
