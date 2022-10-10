import 'package:cloud_computing_frontend/model/objects/entity/student.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/model.dart';
import '../../components/page_title.dart';

class AddStudentPage extends StatefulWidget {
  static const String route = '/addStudent';
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {

  late String _name;
  late String _surname;
  late String _email;
  late String _registrationNumber;
  late String _department;
  late String _degreeCourse;

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return SafeArea(
        child: new Scaffold(
            appBar: new AppBar(
              elevation: 0.1,
              backgroundColor: Colors.red.shade700,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    PageTitle('Add Student'),
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                    Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: "name",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                                validator: (value) => _validateRequired(value!),
                                onSaved: (value) => _name = value!,
                                onFieldSubmitted: null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              TextFormField(
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: "surname",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                                validator: (value) => _validateRequired(value!),
                                onSaved: (value) => _surname = value!,
                                onFieldSubmitted: null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              TextFormField(
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: "email",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                                validator: (value) => _validateRequired(value!),
                                onSaved: (value) => _email = value!,
                                onFieldSubmitted: null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              TextFormField(
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: "registration number",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                                validator: (value) => _validateRequired(value!),
                                onSaved: (value) => _registrationNumber = value!,
                                onFieldSubmitted: null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              TextFormField(
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: "department",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                                validator: (value) => _validateRequired(value!),
                                onSaved: (value) => _department = value!,
                                onFieldSubmitted: null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              TextFormField(
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: "degree Course",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                                validator: (value) => _validateRequired(value!),
                                onSaved: (value) => _degreeCourse = value!,
                                onFieldSubmitted: null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              GestureDetector(
                                onTap:(){
                                  _addStudent();
                                },
                                child: Container(
                                  height: 40.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.red.shade900,
                                    elevation: 7.0,
                                    child: Center(
                                      child: Text("register",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )));
  }


  _validateRequired(String value) {
    if (value.isEmpty || value == null)
      return "required";
    else
      return null;
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

  Future<void> _addStudent() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Processing Data'),
        duration: Duration(seconds: 1),
      ));
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      Student student = new Student(name: _name, surname: _surname, department: _department, email: _email, degreeCourse: _degreeCourse, registrationNumber: _registrationNumber);
      Model.sharedInstance.addStudent(student).then((result){
        if(result != null) _successDialog("Added");
        else _errorDialog("not added");
      });
    }
  }


}