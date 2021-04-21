import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
    BuildContext context,{
    @required String title,
    @required String content,
    @required String defaultActionText,
    String cancelActionText 
    }) {
  if (!Platform.isIOS) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                if (cancelActionText!=null)
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(defaultActionText)),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(defaultActionText)),
              ],
            ));
  } else {
    return showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                if (cancelActionText!=null)
                  TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(cancelActionText)),
                CupertinoDialogAction(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(defaultActionText)),
              ],
            ));
  }
}
