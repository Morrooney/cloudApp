import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  final String titleText;
  final String bodyText;


  const MessageDialog({required this.titleText, required this.bodyText});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text(
            titleText,
            textAlign: TextAlign.center
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            child: Text(
              bodyText,
              textAlign: TextAlign.center,
            ),
          ),
        ]
    );
  }
}