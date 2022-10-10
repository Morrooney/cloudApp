import 'package:cloud_computing_frontend/UI/pages/common/login.dart';
import 'package:cloud_computing_frontend/model/objects/entity/student.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';

import '../../../model/model.dart';
import '../../../model/objects/entity/docent.dart';
import '../../../model/support/login_result.dart';

class SignupPage extends StatefulWidget {

  static const String route = '/Signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  late LoginResult _loginResult;
  late String _email;
  late String _password;
  late bool _isAStudent;
  late bool _passwordVisible;

  @override
  void initState()
  {
    _passwordVisible = false;
  }



  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return new Scaffold(
            body: SingleChildScrollView(
              child:
                Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Center(
                            child: Container(
                                width: 300,
                                height: 200,
                                child: Text("Signup",
                                    style: TextStyle(
                                        color: Colors.red.shade900,
                                        fontSize: 90.0,
                                        fontWeight: FontWeight.bold)),),
                          ),
                        ),

                        Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),),
                                      labelText: 'EMAIL',
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:Colors.red.shade900),
                                    ),
                                    validator: (value) => _validateEmail(value!),
                                    onSaved: (value) => _email = value!,
                                    onFieldSubmitted: null,
                                  ),
                                  Padding(padding: EdgeInsets.all(5)),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),),
                                      labelText: 'PASSWORD',
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red.shade900),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Theme.of(context).primaryColorDark,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                    validator: (value) => _validatePassword(value!),
                                    onSaved: (value) => _password = value!,
                                    onFieldSubmitted: null,
                                    obscureText: !_passwordVisible,
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 10.0)),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _isAStudent = false;
                                            _signup();},
                                          child: Container(
                                            height: 40.0,
                                            child: Material(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.red.shade900,
                                              elevation: 7.0,
                                              child: Center(
                                                child: Text(
                                                  "docent register",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),),
                                      Padding(padding: EdgeInsets.all(10)),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap:(){
                                            _isAStudent = true;
                                            _signup();},
                                          child: Container(
                                            height: 40.0,
                                            child: Material(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.red.shade900,
                                              elevation: 7.0,
                                              child: Center(
                                                child: Text(
                                                  "student register",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),)
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.all(10)),
                                  Container(
                                    height: 40.0,
                                    color: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                              width: 1.0),
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(10.0)),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(LoginPage.route);
                                        },
                                        child:

                                        Center(
                                          child: Text('Go Back',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat')),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
            ),
          backgroundColor: Colors.white,
            );
  }


  _errorDialog(String title) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: title,
        backgroundColor: Colors.red.shade100,
        confirmBtnColor: Colors.red.shade900,
        onConfirmBtnTap: () => Navigator.pop(context));
  }

  _successDialog(String title) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title:
        "registered",
        backgroundColor: Colors.red.shade100,
        confirmBtnColor: Colors.lightGreen,
        onConfirmBtnTap: () =>
        {Navigator.pop(context), Navigator.pop(context)});
  }

  _validateEmail(String value) {
    if (value.isEmpty || value == null) {
      return "required";
    }
    return null;
  }

  _validatePassword(String value) {
    if (value.isEmpty || value == null)
      return "required";
    else if (value.length < 6)
      return "pwd_min_6_char";
    else if (value.length > 15)
      return "pwd_max_25_char";
    else
      return null;
  }


  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Processing Data'),
        duration: Duration(seconds: 1),
      ));

      Student? student;
      Docent? docent;

      if(_isAStudent) student = await Model.sharedInstance.studentRegistration(_email, _password);
      else{
        docent = await Model.sharedInstance.docentRegistration(_email, _password);
        print(docent.toString());
      }
      if (student == null && _isAStudent) _errorDialog("Student not insert in the Database");
      else if(docent == null && !_isAStudent) _errorDialog("Docent not insert in the Database");
      else {
        _successDialog("registered");
      }
    }
  }

}