import 'package:cloud_computing_frontend/UI/pages/common/thesis_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import '../../model/objects/entity/thesis.dart';


class ThesesCards extends StatefulWidget {

  List<Thesis> docentTheses;


  ThesesCards({required this.docentTheses});

  @override
  _ThesesCardsState createState() => _ThesesCardsState();
}

class _ThesesCardsState extends State<ThesesCards> {



  @override
  void initState() {
    //_getDocentThesis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: widget.docentTheses.length,
        itemBuilder: (context, index) {
          return SingleCardThesis(thesis: widget.docentTheses[index],);
        }
    );
  }

 /*
  Future<void> _getDocentThesis() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String docentEmail = sharedPreferences.getString('email')!;
    Model.sharedInstance.showDocentThesis(docentEmail).then((result){
      setState((){
        tesiOttenute = true;
        _docentTheses = result!;
      });
    });
  }
  */
}

class SingleCardThesis extends StatefulWidget {

  Thesis thesis;

  SingleCardThesis({required this.thesis});

  @override
  State<SingleCardThesis> createState() => _SingleCardThesisState();
}

class _SingleCardThesisState extends State<SingleCardThesis> {

  late SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Card(
        semanticContainer: true,
        margin: EdgeInsets.fromLTRB(6.0,10, 6.0, 4.0),
        elevation: 3,
        child: ListTile(

          leading: new Icon(
            Icons.book,
            size: 30,
          ),


          title: new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text('${widget.thesis.title}'),
          ),

          subtitle: new Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text(
              "${widget.thesis.thesisStudent.name} "+"${widget.thesis.thesisStudent.surname}",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ),

          trailing:new IconButton(
            splashRadius: 20,
            icon: new Icon(Icons.arrow_forward),
            onPressed: (){
              saveSelectThesisId();
              Navigator.of(context).pushNamed(
                  ThesisDetails.route,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> saveSelectThesisId() async{
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setInt("thesisId", widget.thesis.id);
  }
}






