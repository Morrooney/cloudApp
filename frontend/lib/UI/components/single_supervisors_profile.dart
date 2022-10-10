import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/objects/entity/docent.dart';
import '../pages/common/docent_page_chat.dart';
import 'circular_profile.dart';

class SingleSupervisorProfile extends StatefulWidget {

  Docent docent;
  String? userEmail;

  SingleSupervisorProfile({required this.docent, required this.userEmail});

  @override
  State<SingleSupervisorProfile> createState() => _SingleSupervisorProfileState();
}

class _SingleSupervisorProfileState extends State<SingleSupervisorProfile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
      child:
      InkWell(
        borderRadius: BorderRadius.circular(75),
        onTap:(widget.userEmail != widget.docent.email)?(){
          Navigator.of(context).pushNamed(
            DocentProfileChatPage.route,
            arguments: widget.docent.toJson(),
          );
        }: null,
        child: CirculaProfile(75.0,'${widget.docent.name}','${widget.docent.surname}'),
      ),
    );
  }
}