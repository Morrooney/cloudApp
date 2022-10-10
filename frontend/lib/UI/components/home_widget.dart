import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circular_profile.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget(this.radius, this.name,this.surname, this.email) : super();

  final double radius;
  final String name;
  final String surname;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child:Container(
            child: CirculaProfile(radius,name,surname),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
          child: new Text(
              "${name} ${surname}",
              style: TextStyle(color: Colors.black)
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: new Text(
              "${email}",
              style: TextStyle(color: Colors.grey)
          ),
        ),
      ],
    );
  }
}
