import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final Widget? actionButton;

  const HomeHeader({Key? key, this.actionButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
        ),
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Image(
              image: AssetImage("assets/images/logo.png"),
              height: 45,
            ),
            Expanded(child: SizedBox.shrink()),
            actionButton ?? Container(),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
