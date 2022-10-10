import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/objects/entity/student.dart';
import '../../components/circular_profile.dart';
import '../../components/row_detail.dart';
import 'chat_page.dart';



class StudentProfileChatPage extends StatefulWidget {

  static const String route = '/studentProfilewithChat';


  @override
  _StudentProfileChatPageState createState() => _StudentProfileChatPageState();
}

class _StudentProfileChatPageState extends State<StudentProfileChatPage> {

  late Student student;

  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

    student = Student.fromJson(args);

    return Scaffold(
      appBar:buildAppBar(context),
      body:ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child:CirculaProfile(100.0,student.name,student.surname),
            ),
          ),
          const SizedBox(height:24),
          buildName(),
          Divider(),
          Row(
            children: [
              Expanded(
                child: new IconButton(
                  icon: new Icon(CupertinoIcons.chat_bubble_text),
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                      ChatPage.route,
                      arguments: {"senderEmail": student.email},
                    );
                  },
                ),
              ),
            ],
          ),
          Divider(),
          RowDetail("FirstName", student.name),
          Divider(),
          RowDetail("LastName",student.surname),
          Divider(),
          RowDetail("Email", student.email),
          Divider(),
          RowDetail("Department",student.department),
          Divider(),
          RowDetail("Degree Course",student.degreeCourse),
          Divider(),
          RowDetail("registration number", student.registrationNumber),
          Divider(),
        ],
      ),
    );
  }


  Widget buildName(){
    return Column(
      children: [
        Text(
          student.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize:24),
        ),
        const SizedBox(height: 4),
        Text(
          student.surname,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  AppBar buildAppBar(BuildContext context)
  {
    return AppBar(
      leading: BackButton(),
      backgroundColor: Colors.red.shade900,
      elevation: 0,
      centerTitle: true,
      title: Text("Student information"),
    );
  }


}
