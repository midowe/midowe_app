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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.black87, fontSize: 15),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: onPressed,
            child: Text(
              this.linkName,
              style: TextStyle(
                  color: Constants.primaryColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
