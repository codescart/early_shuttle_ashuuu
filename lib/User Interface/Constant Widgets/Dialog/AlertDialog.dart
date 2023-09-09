import 'package:flutter/material.dart';

class ConstantDialog extends StatelessWidget {
  final String title;
  final String message;
  final String positiveButtonText;
  final VoidCallback onPositivePressed;
  final String negativeButtonText;
  final VoidCallback? onNegativePressed;

  ConstantDialog({
    required this.title,
    required this.message,
    required this.positiveButtonText,
    required this.onPositivePressed,
    this.negativeButtonText = 'Cancel',
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (onNegativePressed != null) {
              onNegativePressed!();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(negativeButtonText),
        ),
        TextButton(
          onPressed: () {
            onPositivePressed();
            Navigator.of(context).pop();
          },
          child:Text(positiveButtonText),
        ),
      ],
    );
  }
}
