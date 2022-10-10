import 'package:cloud_computing_frontend/model/objects/entity/person.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Docent extends Person{

  String cardNumber;

  Docent({int? id,required String name, required String surname, required String department, required String email,required String cardNumber}):
   this.cardNumber = cardNumber,
   super(id: id,name: name, surname: surname, department: department, email: email);

  factory Docent.fromJson(Map<String, dynamic> json) {
    return Docent(
      id: (json['id'] == null)?null : json['id'],
      name: json['name'],
      surname: json['surname'],
      department: json['department'],
      email: json['email'],
      cardNumber: json['cardNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
    if(id != null)'id': id,
    'name': name,
    'surname': surname,
    'department': department,
    'email': email,
    'cardNumber': cardNumber,
  };

  //creo l'utente che è acceduto
  void setUserPrefs() async{
    SharedPreferences userData = await SharedPreferences.getInstance();
    userData.setInt("id", id!);
    userData.setString("email", email);
    userData.setString("name", name);
    userData.setString("surname", surname);
    userData.setString("department", department);
    userData.setString("cardNumber", cardNumber);
  }


}