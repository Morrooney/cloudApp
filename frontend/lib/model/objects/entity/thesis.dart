import 'package:cloud_computing_frontend/model/objects/entity/student.dart';

import 'docent.dart';

class Thesis{

  int id;
  String title;
  String type;
  Student thesisStudent;
  Docent mainSupervisor;
  List<Docent>? supervisors;

  Thesis({required this.id,required this.title, required this.type, required this.thesisStudent, required this.mainSupervisor,this.supervisors});

  factory Thesis.fromJson(Map<String, dynamic> json) {
    return Thesis(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      thesisStudent: Student.fromJson(json["thesisStudent"]),
      mainSupervisor: Docent.fromJson(json["mainSupervisor"]),
      supervisors: json['supervisors'] == null? null : List<Docent>.from(json["supervisors"].map((i) => Docent.fromJson(i)).toList()),
    );
  }

  //costruisci oggetto json to dart
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'type': type,
    'thesisStudent': thesisStudent.toJson(),
    'mainSupervisor': mainSupervisor.toJson(),
    'supervisors': supervisors == null? null : supervisors?.map((i) => i.toJson()).toList(),
  };
}