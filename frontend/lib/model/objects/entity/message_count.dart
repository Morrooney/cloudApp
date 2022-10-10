import 'package:cloud_computing_frontend/model/objects/entity/person.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageCount{

  late Person sender;
  int total;

  MessageCount({required this.sender, required this.total});

  factory MessageCount.fromJson(Map<String, dynamic> json) {
    return MessageCount(
      total: json['total'],
      sender: Person.fromJson(json["sender"]),
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'sender': sender.toJson(),
  };

  @override
  String toString() {
    return "Messaggio "+"receiver: "+sender.toString();
  }
}