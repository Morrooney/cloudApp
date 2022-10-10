import 'package:cloud_computing_frontend/UI/components/single_cart_docent.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/model.dart';
import '../../../model/objects/entity/docent.dart';
import '../../components/circular_icon_button.dart';
import '../../components/input_file.dart';

class SearchDocent extends StatefulWidget {


  @override
  _SearchDocentState createState() => _SearchDocentState();
}

class _SearchDocentState extends State<SearchDocent> {
  bool _searching = false;
  List<Docent>? _docents = null;
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
    _docents == null ?
    SizedBox.shrink() :
    _docents!.length == 0 ?
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
          itemCount: _docents!.length,
          itemBuilder: (context, index) {
            Docent docent = _docents![index];
            return (_isAStudent || docent.email != _userEmail)? SingleCartDocent(
              docent: docent,
            ): Container();
          },
        ),
      ),
    );
  }

  void _search() {
    setState(() {
      _searching = true;
      _docents = null;
    });
    Model.sharedInstance.searchDocent(_searchFiledController.text).then((result) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        _isAStudent = sharedPreferences.getBool("isAStudent")!;
        _userEmail = sharedPreferences.getString("email")!;
        _searching = false;
        _docents = result!;
      });
    });
  }


}