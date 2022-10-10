import 'package:flutter/material.dart';

class RowDetail extends StatelessWidget {
  const RowDetail(this.field, this.value) : super();

  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
          child: new Text(
              field,
              style: TextStyle(color: Colors.grey)
          ),
        ),
        Padding(
            padding: EdgeInsets.all(15.0),
            child: new Text(value)
        ),
      ],
    );
  }
}
