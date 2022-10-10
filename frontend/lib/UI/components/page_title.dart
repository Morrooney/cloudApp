import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle(this.text) : super();

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              child: Text(text,
                  style: TextStyle(
                      color: Colors.red.shade900,
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold)),
            ),
          ]),
        ],
      ),
    );
  }
}
