import 'package:cloud_computing_frontend/UI/components/single_cart_docent.dart';
import 'package:cloud_computing_frontend/UI/components/single_cart_student.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/model.dart';
import '../../../model/objects/entity/docent.dart';
import '../../../model/objects/entity/student.dart';
import '../../components/circular_icon_button.dart';
import '../../components/input_file.dart';

class SearchStudent extends StatefulWidget {


  @override
  _SearchStudentState createState() => _SearchStudentState();
}

class _SearchStudentState extends State<SearchStudent> {
  bool _searching = false;
  List<Student>? _students = null;
  late String _userEmail;
  late bool _isAStudent;

  TextEditingController _searchFiledController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            top(),
            bottom(),
          ],
        ),
      ),
    );
  }

  Widget top() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          Flexible(
            child: InputField(
              labelText: "search",
              controller: _searchFiledController,
              onSubmit: (value) {
                _search();
              },
            ),
          ),
          CircularIconButton(
            icon: Icons.search_rounded,
            onPressed: () {
              _search();
            },
          ),
        ],
      ),
    );
  }

  Widget bottom() {
    return  !_searching ?
    _students == null ?
    SizedBox.shrink() :
    _students!.length == 0 ?
    noResults() :
    yesResults() :
    CircularProgressIndicator();//*************************IMPORTANTE
  }

  Widget noResults() {
    return Text("no_results" + "!");
  }

  Widget yesResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _students!.length,
          itemBuilder: (context, index) {
            Student student = _students![index];
            return (!_isAStudent || student.email != _userEmail)? SingleCartStudent(
              student: student,
            ): Container();
          },
        ),
      ),
    );
  }

  void _search() {
    setState(() {
      _searching = true;
      _students = null;
    });
    Model.sharedInstance.searchStudent(_searchFiledController.text).then((result) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        _isAStudent = sharedPreferences.getBool("isAStudent")!;
        _userEmail = sharedPreferences.getString("email")!;
        _searching = false;
        _students = result!;
      });
    });
  }


}