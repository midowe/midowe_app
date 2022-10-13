import 'package:flutter/material.dart';

class TitleSubtitleHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  TitleSubtitleHeading(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Text(
            this.subtitle,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
