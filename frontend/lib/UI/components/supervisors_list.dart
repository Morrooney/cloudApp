import 'package:cloud_computing_frontend/UI/components/single_supervisors_profile.dart';
import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import '../../model/objects/entity/docent.dart';
import '../../model/objects/entity/thesis.dart';
import '../pages/common/docent_page_chat.dart';
import 'circular_profile.dart';


class SupervisorsList extends StatefulWidget {

  List<Docent>? supervisors;
  String? userEmail;

  SupervisorsList({required this.supervisors, required this.userEmail});
  @override
  _SupervisorsListState createState() => _SupervisorsListState();
}

class _SupervisorsListState extends State<SupervisorsList> {



  @override
  Widget build(BuildContext context) {
    return Container(
        height: 165,
        child: new ListView.builder(
          shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.supervisors!.length,
        itemBuilder: (context, index) {
          return SingleSupervisorProfile(docent: widget.supervisors![index], userEmail: widget.userEmail);
        },
      ),
    );
  }

}








