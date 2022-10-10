import 'package:cloud_computing_frontend/UI/components/dialog_window.dart';
import 'package:cloud_computing_frontend/UI/pages/common/notifications_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/search.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/docent_personal_page.dart';
import 'package:cloud_computing_frontend/UI/pages/common/login.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/docent_registration_page.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/student_registration_page.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/theses_page.dart';
import 'package:cloud_computing_frontend/UI/pages/docent/thesis_registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/circular_profile.dart';
import '../../components/home_widget.dart';

class DocentHomePage extends StatefulWidget {
  static const String route = '/docentHomePage';

  @override
  _DocentHomePageState createState() => _DocentHomePageState();
}

class _DocentHomePageState extends State<DocentHomePage> {


  bool _docentObtained = false;
  late String _docentName;
  late String _docentSurname;
  late String _docentEmail;

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
        backgroundColor: Colors.red.shade900,
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
      drawer: _buildMenu(),
    );
  }

  _buildMenu(){
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          if(_docentObtained)_docentObtained? HomeWidget(70,_docentName,_docentSurname,_docentEmail): _attendData(),
          SizedBox(height: 20,),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(DocentProfilePage.route);
            },
            child: ListTile(
              title: Text("My account"),
              leading: Icon(Icons.person),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ThesesPage.route);
            },
            child: ListTile(
              title: Text("My Theses"),
              leading: Icon(Icons.book),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AddStudentPage.route);
            },
            child: ListTile(
              title: Text("Add Student"),
              leading: Icon(Icons.person_add_alt),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AddDocentPage.route);
            },
            child: ListTile(
              title: Text("Add Docent"),
              leading: Icon(Icons.person_add),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AddThesisPage.route);
            },
            child: ListTile(
              title: Text("Add Thesis"),
              leading: Icon(Icons.add_circle_outline),
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
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
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
    );
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
      _docentName = sharedPreferences.getString('name')!;
      _docentSurname = sharedPreferences.getString('surname')!;
      _docentEmail = sharedPreferences.getString('email')!;
      _docentObtained = true;
    });
  }

}
