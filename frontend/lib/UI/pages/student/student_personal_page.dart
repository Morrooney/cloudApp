import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_computing_frontend/model/objects/entity/docent.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/objects/entity/student.dart';
import '../../components/circular_profile.dart';
import '../../components/row_detail.dart';



class StudentProfilePage extends StatefulWidget {

  static const String route = '/studentProfile';


  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {

  late Student _student;
  late bool _studentObtained = false;

  @override
  void initState(){
    _pullData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:buildAppBar(context),
      body: _studentObtained? _buildBody() : _attendData(),
    );
  }


  _buildBody()
  {
   return ListView(
     physics: BouncingScrollPhysics(),
     children: [
       Center(
         child: Padding(
           padding: const EdgeInsets.all(10),
           child:CirculaProfile(100.0,_student.name,_student.surname),
         ),
       ),
       const SizedBox(height:10),
       _buildName(),
       const SizedBox(height:24),
       Divider(),
       RowDetail("FirstName","${_student.name}"),
       Divider(),
       RowDetail("LastName","${_student.surname}"),
       Divider(),
       RowDetail("Email","${_student.email}"),
       Divider(),
       RowDetail("Department","${_student.department}"),
       Divider(),
       RowDetail("Degree Course","${_student.degreeCourse}"),
       Divider(),
       RowDetail("registration number","${_student.registrationNumber}"),
       Divider(),
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
      title: Text("My account"),
    );
  }

  Widget _buildName(){
    return Column(
      children: [
        Text(
          '${_student.name}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize:24),
        ),
        const SizedBox(height: 4),
        Text(
          '${_student.surname}',
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }


  Future<void> _pullData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _student = new Student(
          name : sharedPreferences.getString('name')!,
          surname : sharedPreferences.getString('surname')!,
          email :sharedPreferences.getString('email')!,
          department : sharedPreferences.getString('department')!,
          registrationNumber: sharedPreferences.getString('registrationNumber')!,
          id : sharedPreferences.getInt('id')!,
          degreeCourse: sharedPreferences.getString('degreeCourse')!,);
      _studentObtained = true;
    });
  }
  _attendData(){
    return Padding(
        padding: const EdgeInsets.all(50),
        child:Center(child: CircularProgressIndicator()));
  }

}

