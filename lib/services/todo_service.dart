import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_todo/models/new_note.dart';
import 'package:my_todo/models/note.dart';
import 'package:my_todo/models/notes.dart';
import 'package:my_todo/services/api_response.dart';


const client_id = '7af367b37d5644df84f735cf381b3334';
const client_secret = '84cc82e7e9164feb8d1cb881cf9551a3';

const access_token = '6bfc28d747840ddeb94c72cef5ea512ffdddd938';






class TodoService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': 'be4c42bf-a6a0-4809-b74d-3bffc907e898',
    'Content-Type': 'application/Json'
  };


  //


  Future<APIResponse<List<Notes>>> geNotetList() {
   return http.get(Uri.parse(API + '/notes'),  headers: headers).then((data) {
      print(data.body);
      print(data.statusCode);

      if(data.statusCode == 200){
        List<Notes> notes = [];

        for (var item in json.decode(data.body)){
         notes.add(Notes.fromJson(item));
        }
        return APIResponse<List<Notes>>(
          data: notes,
          error: false,
          errorMessage: ''
        );
      }

      return APIResponse<List<Notes>>(
          error: true,
          errorMessage: 'An error occured! ${data.statusCode}'
      );
    }).catchError((error) {
      return APIResponse<List<Notes>>(
          error: true,
          errorMessage: 'An error occured: $error'
      );
    });
  }

  Future<APIResponse<Note>> geNote(String noteId) {
   return http.get(Uri.parse(API + '/notes/' + noteId),  headers: headers).then((data) {
      print(data.body);
      print(data.statusCode);

      if(data.statusCode == 200){

        Note note = new Note();

         note = Note.fromJson(json.decode(data.body));

         print(note);

        return APIResponse<Note>(
          data: note,
          error: false,
          errorMessage: ''
        );
      }

      return APIResponse<Note>(
          error: true,
          errorMessage: 'An error occured! ${data.statusCode}'
      );
    }).catchError((error) {
      return APIResponse<Note>(
          error: true,
          errorMessage: 'An error occured: $error'
      );
    });
  }

  Future<APIResponse<bool>> createNote(NewNote note){
    return http.post(Uri.parse(API + '/notes/'), headers:headers, body: json.encode(note.toJson())).then((data) {
      if(data.statusCode == 201) {
        return APIResponse(
          data: true,
          errorMessage: "Something went wrong ${data.statusCode}",
          error: false
        );

      }
      return  APIResponse(
          data: false,
          errorMessage: "",
          error: true
      );
    })
    .catchError((error ) {
      return  APIResponse(
          data: false,
          errorMessage: "Something went wrong ${error}",
          error: true
      );
    });

  }


}
