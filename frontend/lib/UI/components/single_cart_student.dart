import 'package:cloud_computing_frontend/UI/pages/common/student_page_chat.dart';
import 'package:cloud_computing_frontend/model/objects/entity/student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/objects/entity/docent.dart';
import '../pages/common/docent_page_chat.dart';

class SingleCartStudent extends StatelessWidget {

  Student student;

  SingleCartStudent({
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Card(
        semanticContainer: true,
        margin: EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 4.0),
        elevation: 3,
        child: ListTile(

          leading: new Icon(
            CupertinoIcons.person_alt_circle,
            size: 45,
          ),

          title: new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text(student.email),
          ),

          subtitle: new Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
            child: new Text(
              "department: "+student.department,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),

          trailing: InkWell(
            borderRadius: BorderRadius.circular(20) ,
            onTap: (){
              Navigator.of(context).pushNamed(
                StudentProfileChatPage.route,
                arguments: student.toJson(),);
            },
            child: new IconButton(
              icon: Icon(Icons.read_more),
              onPressed: null,
            ),
          ),
        ),
      ),
    );
  }
}