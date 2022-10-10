import 'dart:async';

import 'package:cloud_computing_frontend/UI/components/thesis_files.dart';
import 'package:cloud_computing_frontend/UI/pages/common/dropped_file_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/login.dart';
import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;

import '../../../model/model.dart';
import '../../../model/objects/entity/file.dart';
import '../../../model/objects/entity/thesis.dart';
import '../docent/docent_home_page.dart';
import '../student/student_home_page.dart';

class FilesPage extends StatefulWidget {
  static const String route = '/filePage';


  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {


 late Thesis thesis;
 late bool _isAStudent;
 late List<File> _thesisFiles;
 bool obtainedFiles = false;

  @override
  void initState(){
    super.initState();
    _pullData();
  }




 @override
  Widget build(BuildContext context) {

    Map<String,dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    thesis = Thesis.fromJson(args);

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor:  Colors.red.shade900,
        centerTitle: true,
        title: Text("Files"),
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
      body: obtainedFiles? ThesisFiles(thesisFiles: _thesisFiles):
      _attendData(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade900,
        onPressed:(){
          Navigator.of(context).pushNamed(
              DropFilePage.route,
              arguments: thesis.toJson(),
          ).then((value) => _pullData());
        },
        tooltip: 'Add File',
        child: const Icon(Icons.add),
      ),
    );
  }


 Future<void> _pullData() async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   Model.sharedInstance.getThesisFiles(thesis.id).then((result){
     setState((){
       _isAStudent = sharedPreferences.getBool("isAStudent")!;
       obtainedFiles = true;
       _thesisFiles = result!;
     });
   });
 }

 _attendData(){
   return Padding(
       padding: const EdgeInsets.all(50),
       child:Center(child: CircularProgressIndicator()));
 }
}

