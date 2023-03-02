import 'package:flutter/material.dart';
import 'package:midowe_app/helpers/constants.dart';

class PrimaryButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Icon icon;
  final Color backgroundColor;
  final Color textColor;

  PrimaryButtonIcon(
      {required this.text,
      required this.icon,
      required this.onPressed,
      this.backgroundColor = Constants.primaryColor,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: this.onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor, backgroundColor: backgroundColor,
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.text,
            style: TextStyle(fontSize: 15.0, color: textColor),
          ),
          SizedBox(width: 15),
          this.icon,
        ],
      ),
    );
  }
}
