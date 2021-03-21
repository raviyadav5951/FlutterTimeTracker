import 'package:new_timetracker/common_widgets/custom_elevated_button.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton(
      {@required String text,
      Color color,
      Color textColor,
      ui.VoidCallback onPressed,
      @required String assetName})
      : assert(text != null),
        assert(assetName != null),
        super(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(assetName),
                Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: 15.0),
                ),
                Opacity(opacity: 0.0, child: Image.asset(assetName))
              ],
            ),
            color: color,
            onPressed: onPressed,
            height: 50.0);
}
