import 'package:flutter/material.dart';


class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const CircularIconButton({required this.icon, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(1),
        child: RawMaterialButton(
          onPressed: onPressed,
          elevation: 2.0,
          fillColor: Colors.red.shade900,
          child: Icon(icon, color: Colors.white),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        )
    );
  }


}