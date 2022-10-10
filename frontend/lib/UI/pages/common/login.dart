import 'package:cloud_computing_frontend/UI/pages/common/signup_page.dart';
import 'package:cloud_computing_frontend/UI/pages/student/student_home_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../model/model.dart';
import '../../../model/objects/entity/docent.dart';
import '../../../model/objects/entity/student.dart';
import '../../../model/support/login_result.dart';
import '../docent/docent_home_page.dart';
import 'package:cloud_computing_frontend/UI/components/dialog_window.dart';


class LoginPage extends StatefulWidget {

  static const String route = '/login';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late SharedPreferences _sharedPreferences;
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

  @override
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
                        child: Image.asset('assets/logoUnical.png')),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
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
                          Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
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
                          Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                onTap: (){
                                  _isAStudent = false;
                                  _login();
                                },
                                child: Container(
                                  height: 40.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.red.shade900,
                                    elevation: 7.0,
                                    child: Center(
                                      child: Text(
                                        "docent login",
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
                                onTap:  (){
                                  _isAStudent = true;
                                  _login();
                                },
                                child: Container(
                                  height: 40.0,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.red.shade900,
                                    elevation: 7.0,
                                    child: Center(
                                      child: Text(
                                        "student login",
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
                        ],
                      ),
                    )
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to the platform ?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(SignupPage.route);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.red.shade900,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
        ),
          backgroundColor: Colors.white,
        );
  }


  _showErrorDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogWindow(title: title, content: message);
        });
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


  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Processing Data'),
        duration: Duration(seconds: 1),
      ));

      _sharedPreferences = await SharedPreferences.getInstance();
      _sharedPreferences.setBool("isAStudent", _isAStudent);



      Student? student = null;
      Docent? docent = null;
      if(_isAStudent) await Model.sharedInstance.studentLogin(_email,_password).then((value){
        if (value != null) {
          student = value;
          student?.setUserPrefs();
        }
      });
      else await Model.sharedInstance.docentLogin(_email,_password).then((value){
        if(value != null){
          docent = value;
          docent?.setUserPrefs();
        }
      });
      if (student == null && _isAStudent) _errorDialog("Student not insert in the Database");
      else if(docent == null && !_isAStudent) _errorDialog("Docent not insert in the Database");
      else if(student != null && _isAStudent){Navigator.of(context).pushNamed(StudentHomePage.route);}
      else if(docent != null && !_isAStudent){Navigator.of(context).pushNamed(DocentHomePage.route);}
      else _errorDialog("Error");
    }
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



}