import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogWindow extends StatelessWidget {

  const DialogWindow({required this.title, required  this.content}) : super();

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: new Text(content,
          textAlign: TextAlign.center),
      actions: <Widget>[
        new MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: new Text(
            "close",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
        ),
      ],
    );
  }
}


