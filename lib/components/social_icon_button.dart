import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;

  SocialIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.black12,
        child: InkWell(
          splashColor: Colors.black26, // Splash color
          onTap: onPressed,
          child: SizedBox(width: 55, height: 55, child: this.icon),
        ),
      ),
    );
  }
}
