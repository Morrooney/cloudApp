import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_computing_frontend/UI/pages/common/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/objects/entity/docent.dart';
import '../../components/circular_profile.dart';
import '../../components/row_detail.dart';



class DocentProfileChatPage extends StatefulWidget {

  static const String route = '/docentProfilewithChat';


  @override
  _DocentProfileChatPageState createState() => _DocentProfileChatPageState();
}

class _DocentProfileChatPageState extends State<DocentProfileChatPage> {

  late Docent docent;

  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;

    docent = Docent.fromJson(args);

    return Scaffold(
      appBar:buildAppBar(context),
      body:ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child:Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:CirculaProfile(100.0,docent.name,docent.surname),
                ),
              ),
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
                        arguments: {"senderEmail": docent.email},
                    );
                  },
                ),
              ),
            ],
          ),
          Divider(),
          RowDetail("FirstName",docent.name),
          Divider(),
          RowDetail("LastName",docent.surname),
          Divider(),
          RowDetail("Email",docent.email),
          Divider(),
          RowDetail("Department",docent.department),
          Divider(),
          RowDetail("Card number",docent.cardNumber),
          Divider(),
        ],
      ),
    );
  }


  Widget buildName(){
   return Column(
     children: [
       Text(
         docent.name,
         style: TextStyle(fontWeight: FontWeight.bold, fontSize:24),
       ),
       const SizedBox(height: 4),
       Text(
         docent.surname,
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
      title: Text("Docent information"),
    );
  }
}
