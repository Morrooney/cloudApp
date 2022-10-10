import 'package:shared_preferences/shared_preferences.dart';

class Person {
  int? id;
  String name;
  String surname;
  String department;
  String email;



  Person({this.id, required this.name, required this.surname, required this.department, required this.email});

  //costruisci l'oggetto dart dall'oggeto json
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      department: json['department'],
      email: json['email'],
    );
  }

  //costruisci oggetto json to dart
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'surname': surname,
    'department': department,
    'email': email,
  };

  @override
  String toString() {
    return name + " " + surname;
  }

}