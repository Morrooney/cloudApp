import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/objects/entity/docent.dart';
import '../../components/circular_profile.dart';
import '../../components/row_detail.dart';



class DocentProfilePage extends StatefulWidget {

  static const String route = '/docentProfile';


  @override
  _DocentProfilePageState createState() => _DocentProfilePageState();
}

class _DocentProfilePageState extends State<DocentProfilePage> {

  late Docent _docent;
  late bool _docentObtained = false;

  @override
  void initState(){
    _pullData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppBar(),
      body:  _docentObtained? _buildBody() : _attendData(),
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
            child:CirculaProfile(100.0,_docent.name,_docent.surname),
          ),
        ),
        const SizedBox(height:10),
        _buildName(),
        const SizedBox(height:24),
        Divider(),
        RowDetail("FirstName","${_docent.name}"),
        Divider(),
        RowDetail("LastName","${_docent.surname}"),
        Divider(),
        RowDetail("Email","${_docent.email}"),
        Divider(),
        RowDetail("Department","${_docent.department}"),
        Divider(),
        RowDetail("Card number","${_docent.cardNumber}"),
        Divider(),
      ],
    );
  }



  Widget _buildName(){
    return  Column(
      children: [
        Text(
          '${_docent.name}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize:24),
        ),
        const SizedBox(height: 4),
        Text(
          '${_docent.surname}',
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
  }

  _buildAppBar()
  {
    return AppBar(
      leading: BackButton(),
      backgroundColor: Colors.red.shade900,
      elevation: 0,
      centerTitle: true,
      title: Text("My account"),
    );
  }

  _attendData(){
    return Padding(
        padding: const EdgeInsets.all(50),
        child:Center(child: CircularProgressIndicator()));
  }

  Future<void> _pullData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _docent = new Docent(
        name : sharedPreferences.getString('name')!,
        surname : sharedPreferences.getString('surname')!,
        email :sharedPreferences.getString('email')!,
        department : sharedPreferences.getString('department')!,
        cardNumber: sharedPreferences.getString('cardNumber')!,
        id : sharedPreferences.getInt('id')!,);
      _docentObtained = true;
    });
  }
}


