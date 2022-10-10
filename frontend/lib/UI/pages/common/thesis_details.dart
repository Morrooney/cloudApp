import 'dart:html';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_computing_frontend/UI/components/supervisors_list.dart';
import 'package:cloud_computing_frontend/UI/pages/common/docent_page_chat.dart';
import 'package:cloud_computing_frontend/UI/pages/common/student_page_chat.dart';
import 'package:cloud_computing_frontend/UI/pages/student/student_home_page.dart';
import 'package:cloud_computing_frontend/UI/pages/student/student_personal_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/model.dart';
import '../../../model/objects/entity/thesis.dart';
import '../../components/circular_profile.dart';
import '../../components/dialog_window.dart';
import '../docent/docent_home_page.dart';
import 'dropped_file_page.dart';
import 'files_page.dart';


class ThesisDetails extends StatefulWidget {

  static const String route = '/thesisDetails';

  @override
  _ThesisDetailsState createState() => _ThesisDetailsState();
}

class _ThesisDetailsState extends State<ThesisDetails> {


 String _userEmail = '';
 late String _supervisorEmail;
 late int _thesisId;
 late Thesis _thesis;
 late bool _isAStudent;
 late String _text;
 bool _thesisDetailsObtained = false;

 final _formKey = GlobalKey<FormState>();

 @override
 void initState(){
   _pullData();
   super.initState();
 }

  @override
  Widget build(BuildContext context) {


    return (_userEmail == '')? CircularProgressIndicator() :Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red.shade700,
        centerTitle: true,
        title: Text("Thesis details"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              String homePage = (_isAStudent)? StudentHomePage.route : DocentHomePage.route;
              Navigator.of(context).pushNamed(homePage);
            },
          ),
        ],
      ),
      body:_thesisDetailsObtained? new ListView(
        children: <Widget> [
          _buildSectionTitle("Thesis Details"),
          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
                child: new Text(
                    "Title",
                    style: TextStyle(color: Colors.grey)
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new Text("${_thesis.title}")
              ),
            ],
          ),
          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
                child: new Text(
                    "type",
                    style: TextStyle(color: Colors.grey)
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new Text("${_thesis.type}")
              ),
            ],
          ),
          Divider(),
          _buildSectionTitle("Main Supervisor"),
          Divider(),
          Container(
            height: 165,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
                  child:
                  InkWell(
                    borderRadius: BorderRadius.circular(75),
                    onTap: (_userEmail != _thesis.mainSupervisor.email)? (){
                      Navigator.of(context).pushNamed(
                        DocentProfileChatPage.route,
                        arguments: _thesis.mainSupervisor.toJson(),
                      );
                    }:null,
                    child: CirculaProfile(75.0,"${_thesis.mainSupervisor.name}",'${_thesis.mainSupervisor.surname}'),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          if(_thesis.supervisors?.length != 0 || !_isAStudent) _buildSectionTitle("Supervisors"),
          if(_thesis.supervisors?.length != 0 || !_isAStudent) _buildSupervisorsSection(),
          _buildSectionTitle("Thesis student"),
          Divider(),
          Container(
            height: 165,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
                  child:
                  InkWell(
                    borderRadius: BorderRadius.circular(75),
                    onTap: (_userEmail == _thesis.thesisStudent.email)? null:(){
                      Navigator.of(context).pushNamed(
                          StudentProfileChatPage.route,
                          arguments: _thesis.thesisStudent.toJson(),
                      );
                    },
                    child: CirculaProfile(75.0,'${_thesis.thesisStudent.name}','${_thesis.thesisStudent.surname}'),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          _buildSectionTitle("Thesis Files"),
          Divider(),
          _buildCard(),
        ],
      ): Center(child: CircularProgressIndicator()),
    );
  }


  _buildSupervisorsSection(){
     return Column(
       children: [
         Divider(),
         Row(
           children: [
             if(_thesis.supervisors?.length != 0 ) SupervisorsList(supervisors: _thesis.supervisors,userEmail: _userEmail),
             if(_userEmail == _thesis.mainSupervisor.email)  _buildButtomToAddUser(),
           ],
         ),
         Divider(),
       ],
     );
  }

  _buildButtomToAddUser(){
   return Padding(
     padding: const EdgeInsets.fromLTRB(25,10.0, 10.0, 5.0),
     child: FloatingActionButton(
       backgroundColor: Colors.red.shade900,
       onPressed:(){
         showDialog(
             context: context,
             builder: (context) {
               return _buildAlertInteraction();
             });
       },
       tooltip: 'Add supervisor',
       child: const Icon(Icons.add),
     ),
   );
  }

  _buildCard(){
    return Container(
      height: 80,
      width: 80,
      child: Card(
        color: Colors.white,
        semanticContainer: true,
        margin: EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 4.0),
        elevation: 3,
        child: ListTile(
          leading: InkWell(
            onTap: null,
            child: new Icon(
              Icons.folder,
              size: 45,
            ),
          ),
          title: new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text("Thesis files"),
          ),
          subtitle: new Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
            child: new Text(
              "All thesis files ",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ),
          trailing: new FittedBox(
            fit: BoxFit.fill,
            child: new Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.arrow_circle_right_outlined),
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                        FilesPage.route,
                        arguments: _thesis.toJson(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSectionTitle(String text){
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 5.0),
      child: new Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 50,
        ),
      ),
    );
  }

  _buildAlertInteraction(){
    return new AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: new Text(
        "Add docent",
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: MediaQuery.of(context).size.width*0.45,
        height: MediaQuery.of(context).size.height *0.50,
        child: Form(
         key:_formKey,
         child: Column(
           children: [
             TextFormField(
               decoration: InputDecoration(
                 hintText: 'write docent email...',
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(30),),
                 labelStyle: TextStyle(
                     fontWeight: FontWeight.bold,
                     color:Colors.red.shade900),
               ),
               validator: (value) => _validateRequired(value!),
               onSaved: (value) => _supervisorEmail = value!,
               onFieldSubmitted: null,
             ),
             Padding(padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0)),
             TextFormField(
               maxLines: 10,
               minLines: 3,
               decoration: InputDecoration(
                 hintText: 'write a message...',
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),),
                 labelStyle: TextStyle(
                     fontWeight: FontWeight.bold,
                     color:Colors.red.shade900),
               ),
               textCapitalization: TextCapitalization.sentences,
               validator: (value) => _validateRequired(value!),
               onChanged: (value) {
                 _text = value;
               },
               onFieldSubmitted: (value) {
                 _text = value;
               },
             ),
           ],
         ),
        ),
      ),
      actions: <Widget>[
        new MaterialButton(
          onPressed: () {
            _addSupervisor();
          },
          child: new Text(
            "select",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade900,
            ),
          ),
        ),
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

 _validateRequired(String value) {
   if (value.isEmpty || value == null)
     return "required";
   else
     return null;
 }

 _successDialog(String title) {
   CoolAlert.show(
       context: context,
       type: CoolAlertType.success,
       title:
       "registered",
       backgroundColor: Colors.green,
       confirmBtnColor: Colors.lightGreen,
       onConfirmBtnTap: () =>
       {Navigator.pop(context), Navigator.pop(context)});
 }

 _errorDialog(String title) {
   CoolAlert.show(
       context: context,
       type: CoolAlertType.error,
       title: "UNKWOWN ERROR",
       backgroundColor: Colors.green,
       confirmBtnColor: Colors.lightGreen,
       onConfirmBtnTap: () => Navigator.pop(context));
 }

 Future<void> _pullData() async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   setState((){
     _userEmail = sharedPreferences.getString("email")!;
     _isAStudent = sharedPreferences.getBool("isAStudent")!;
   });
   (_isAStudent)?_getStudentThesisDetails():_getThesisDetails();
 }


 Future<void> _getStudentThesisDetails() async {
   Model.sharedInstance.showStudentThesis(_userEmail).then((result){
     setState((){
       _thesis = result!;
       _thesisDetailsObtained = true;
     });
   });
 }

 Future<void> _getThesisDetails() async {

   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   setState((){
     _thesisId = sharedPreferences.getInt("thesisId")!;
   });

   Model.sharedInstance.getThesis(_thesisId).then((result){
     setState((){
       _thesis = result!;
       _thesisDetailsObtained = true;
     });
   });
 }

 _addSupervisor() async {
   if (_formKey.currentState!.validate()) {
     _formKey.currentState!.save();
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text('Processing Data'),
       duration: Duration(seconds: 1),
     ));

     Model.sharedInstance.addSupervisor(_userEmail,_thesis.id,_supervisorEmail).then((result){
       if(result != null){
         Model.sharedInstance.sendMessage(_userEmail,_supervisorEmail,_text);
         _successDialog("Added");
         _getThesisDetails();
       }
       else _errorDialog("not added");
     });
   }
 }
}


