import 'package:cloud_computing_frontend/UI/pages/common/login.dart';
import 'package:cloud_computing_frontend/UI/pages/student/student_personal_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/model.dart';
import '../../../model/objects/entity/thesis.dart';
import '../../components/dialog_window.dart';
import '../../components/home_widget.dart';
import '../common/notifications_page.dart';
import '../common/search.dart';

class StudentHomePage extends StatefulWidget {
  static const String route = '/studentHomePage';


  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {


  late bool _studentObtained = false;
  late String _studentName;
  late String _studentSurname;
  late String _studentEmail;

  @override
  void initState()
  {
    _pullData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor:  Colors.red.shade900,
        centerTitle: true,
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(
                  Search.route
              );
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child:new ListView(
          children:<Widget>[
            if(_studentObtained)_studentObtained? HomeWidget(70,_studentName,_studentSurname,_studentEmail): _attendData(),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(StudentProfilePage.route);
              },
              child: ListTile(
                title: Text("My account"),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap:(){_getStudentThesis();},
              child: ListTile(
                title: Text("My Thesis"),
                leading: Icon(Icons.book),
              ),
            ),
            InkWell(
              onTap: () {

                Navigator.of(context).pushNamed(NotificationsPage.route);
              },
              child: ListTile(
                title: Text("Notifications"),
                leading: Icon(CupertinoIcons.bell),
              ),
            ),
            Divider(),
            InkWell(
              onTap:(){
                showDialog(
                    context: context,
                    builder: (context){
                      return DialogWindow(title: "About", content: "A simple platform for \n the management of \n degree theses");
                    });
              },
              child: ListTile(
                title: Text("About"),
                leading: Icon(Icons.help),
              ),
            ),
            InkWell(
                onTap: () {
                  _clearAll();
                  Navigator.pushNamedAndRemoveUntil(context, LoginPage.route , (r) => false);
                },
              child: ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getStudentThesis() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String studentEmail = sharedPreferences.getString('email')!;
    Model.sharedInstance.showStudentThesis(studentEmail).then((value){
      if(value != null){
      sharedPreferences.setBool("isAStudent", true);
      Navigator.of(context).pushNamed(
        ThesisDetails.route
      );
      }
      else
      {
        showDialog(
            context: context,
            builder: (context){
              return DialogWindow(title: "Sorry!", content: "You don't have a thesis yet");
            });
      }
    });
  }

  _clearAll() async{
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.clear();
  }

  _attendData(){
    return Padding(
        padding: const EdgeInsets.all(50),
        child:Center(child: CircularProgressIndicator()));
  }

  Future<void> _pullData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState((){
      _studentName = sharedPreferences.getString('name')!;
      _studentSurname = sharedPreferences.getString('surname')!;
      _studentEmail = sharedPreferences.getString('email')!;
      _studentObtained = true;
    });
  }
}

