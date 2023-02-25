import 'package:flutter/material.dart';

class AlertDialogComponent extends StatelessWidget {
  final String dialogTitle;
  final String dialogMessage;

  AlertDialogComponent(this.dialogTitle, this.dialogMessage);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogTitle),
      content: Text(dialogMessage),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
