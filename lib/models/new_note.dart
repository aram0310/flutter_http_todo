import 'package:flutter/cupertino.dart';

class NewNote{
  String noteTitle;
  String noteContent;

  NewNote({@required this.noteTitle, @required this.noteContent});


  Map<String, dynamic> toJson() {
    return {
      "noteTitle": noteTitle,
      "noteContent": noteContent
    };
  }
}