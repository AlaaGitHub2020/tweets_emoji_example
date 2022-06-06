import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar(
      {Key? key,
      required BuildContext context,
      required String text,
      required Color backgroundColor,
      Icon? icon})
      : super(
            key: key,
            backgroundColor: backgroundColor,
            behavior: SnackBarBehavior.floating,
            content: Row(
              children: <Widget>[
                icon ?? Container(),
                if (icon != null) const SizedBox(width: 20) else Container(),
                Text(text),
              ],
            ));
}
