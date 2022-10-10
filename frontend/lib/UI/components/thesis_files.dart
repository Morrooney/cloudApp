import 'package:cloud_computing_frontend/model/objects/entity/file.dart';
import 'package:cloud_computing_frontend/model/objects/entity/thesis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';


class ThesisFiles extends StatefulWidget {


  List<File> thesisFiles;

  ThesisFiles({required this.thesisFiles});

  @override
  _ThesisFilesState createState() => _ThesisFilesState();
}

class _ThesisFilesState extends State<ThesisFiles> {

  //bool fileTesiOttenuti = false;

  /*
  @override
  void initState() {
    _getThesisFiles();
    super.initState();
  }*/


  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: widget.thesisFiles.length,
        itemBuilder: (context, index) {
          return SingleCartFile(
            file : widget.thesisFiles[index],
          );
        }
    );
  }

  /*
  Future<void> _getThesisFiles() async {
    Model.sharedInstance.getThesisFiles(widget.thesisId).then((result){
      setState((){
        fileTesiOttenuti = true;
        _thesisFiles = result!;
      });
    });
  }
*/
}

class SingleCartFile extends StatelessWidget {

 File file;

 SingleCartFile({required this.file});

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

          leading: InkWell(
            borderRadius: BorderRadius.circular(20) ,
            onTap: (){},
            child: new IconButton(
              icon: new Icon(CupertinoIcons.doc_text),
              onPressed: null,
            ),
          ),

          title: new Container(
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 6.0, 6.0),
            child: new Text(file.fileName),
          ),

          subtitle: new Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 3.0, 6.0),
            child: new Text(
              "owner: "+ file.owner,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ),

          trailing:new FittedBox(
            fit: BoxFit.fill,
            child: new Row(
              children: <Widget>[
                new Text(
                  "update time: "+ file.updateTime,
                  //style: TextStyle(),
                ),
                Padding(padding: const EdgeInsets.only(left: 5.0,right: 2.0)),
                new IconButton(
                  splashRadius: 20,
                  icon: new Icon(Icons.download_rounded),
                  onPressed: () {
                    Model.sharedInstance.downloadFile(file.id,file.fileName);
                  },
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}



