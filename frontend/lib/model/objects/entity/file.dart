import 'package:flutter/material.dart';

class File{

  int id;
  String filePath;
  String fileName;
  String owner;
  String typeFile;
  String updateTime;

  File({required this.id, required this.filePath, required this.fileName, required this.owner, required this.typeFile, required this.updateTime});


  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      id: json['id'],
      filePath: json['filePath'],
      fileName: json['fileName'],
      owner: json['owner'],
      typeFile: json['typeFile'],
      updateTime: json['updateTime'],
    );
  }

  //costruisci oggetto json to dart
  Map<String, dynamic> toJson() => {
    'id': id,
    'filePath': filePath,
    'fileName': fileName,
    'owner': owner,
    'typeFile': typeFile,
    'updateTime': updateTime,
  };
}