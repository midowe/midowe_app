import 'package:flutter/material.dart';
import 'package:midowe_app/utils/colors.dart';

class PrimaryButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Icon icon;

  PrimaryButtonIcon(
      {required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: this.onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Constants.primaryColor,
        primary: Colors.white,
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.text,
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
          SizedBox(width: 15),
          this.icon,
        ],
      ),
    );
  }
}
