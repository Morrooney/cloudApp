import 'package:cloud_computing_frontend/model/objects/entity/person.dart';

class Message{

  Person sender;
  Person receiver;
  bool read;
  String messageTime;
  String text;
  int id;

  Message({required this.id, required this.sender, required this.receiver, required this.read, required this.messageTime, required this.text});


  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: Person.fromJson(json['sender']),
      receiver: Person.fromJson(json['receiver']),
      read: json['read'],
      messageTime: json['messageTime'],
      text: json['text'],
    );
  }

  //costruisci oggetto json to dart
  Map<String, dynamic> toJson() => {
    'id': id,
    'sender': sender.toJson(),
    'receiver': receiver.toJson(),
    'read': read,
    'messageTime': messageTime,
    'text': text,
  };
}