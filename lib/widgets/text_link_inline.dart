import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:midowe_app/utils/constants.dart';

class TextLinkInline extends StatelessWidget {
  final String text;
  final String linkName;
  final VoidCallback onPressed;

  const TextLinkInline(
      {Key? key,
      required this.text,
      required this.linkName,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 20),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: "$text ",
              style: TextStyle(color: Colors.black87, fontSize: 15),
            ),
            TextSpan(
                text: this.linkName,
                style: TextStyle(
                    color: Constants.primaryColor,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                recognizer: TapGestureRecognizer()..onTap = () => onPressed),
          ])),
    );
  }
}
