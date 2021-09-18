import 'package:flutter/material.dart';
import 'package:midowe_app/utils/constants.dart';

class PrimaryOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  PrimaryOutlineButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: this.onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Constants.primaryColor,
                  width: 1,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(
          this.text,
          style: TextStyle(fontSize: 15.0, color: Constants.primaryColor),
        ),
      ),
    );
  }
}
