import 'package:cloud_computing_frontend/UI/pages/common/search_docent.dart';
import 'package:cloud_computing_frontend/UI/pages/common/search_student.dart';
import 'package:flutter/material.dart';



import '../../components/message_dialog.dart';
class Search extends StatefulWidget {

  static const String route = '/Search';

  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.red.shade900,
          centerTitle: true,
          title: Text("Search"),
          actions: <Widget>[

          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text:"docent", icon: Icon(Icons.account_box_outlined)),
              Tab(text:"student", icon: Icon(Icons.account_box)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SearchDocent(),
            SearchStudent(),
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => MessageDialog(
          titleText: ("welcome") + "!",
          bodyText: ("description_search_for_guest"),
        )
    );
  }


}
