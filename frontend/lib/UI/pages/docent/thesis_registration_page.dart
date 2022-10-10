import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:cloud_computing_frontend/UI/components/page_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/model.dart';

class AddThesisPage extends StatefulWidget {
  static const String route = '/addThesis';
  @override
  _AddThesisPageState createState() => _AddThesisPageState();
}

class _AddThesisPageState extends State<AddThesisPage> {

  late String _title;
  late String _type;
  late String _studentEmail;


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
                    PageTitle('Add Thesis'),
                    Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                    Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: "title",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                                validator: (value) => _validateRequired(value!),
                                onSaved: (value) => _title = value!,
                                onFieldSubmitted: null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              TextFormField(
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  labelText: "type",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900),
                                ),
                                validator: (value) => _validateRequired(value!),
                                onSaved: (value) => _type = value!,
                                onFieldSubmitted: null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'student email',
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:Colors.red.shade900),
                                ),
                                validator: (value) => _validateRequired(value!),
                                onSaved: (value) => _studentEmail = value!,
                                onFieldSubmitted: null,
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
                              GestureDetector(
                                onTap:(){
                                  _addThesis();
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
        title: "Wrong student email",
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

Future<void> _addThesis() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Processing Data'),
      duration: Duration(seconds: 1),
    ));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String docentEmail = sharedPreferences.getString('email')!;
    Model.sharedInstance.addThesis(_studentEmail,docentEmail,_title,_type).then((result){
      if(result != null) _successDialog("Added");
      else _errorDialog("not added");
    });
  }
}



}