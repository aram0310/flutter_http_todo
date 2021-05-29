import 'dart:convert';

import 'package:my_todo/models/users.dart';
import 'package:my_todo/models/user.dart';
import 'package:my_todo/services/api_response.dart';
import 'package:http/http.dart' as http;



class UsersServices {
  String URL = 'https://reqres.in/api/users/';

  Future<APIResponse<List<Users>>> getAllUsers() {
    return http.get(Uri.parse(URL)).then((userData) {
      // print(userData.body[4]);
      print(json.decode(userData.body)['data']);
      print(userData.statusCode);



      if(userData.statusCode == 200){
        //
        List<Users> users = [];
        for(var user in json.decode(userData.body)['data']){
          users.add(Users.fromJson(user));
        }

        return APIResponse<List<Users>>(
          data: users,
          error: false,
          errorMessage: ''
        );
      }
      return APIResponse<List<Users>>(
          data: [Users(), Users()],
          error: false,
          errorMessage: ''
      );
    });
  }

  Future<APIResponse<User>> getUser(int id) {
    return http.get(Uri.parse(URL + id.toString())).then((userData) {

      // print(json.decode(userData.body)['data']['first_name']);
      //
      //
      // print(User.fromJson(json.decode(userData.body)['data']).lastName);
      // print(User.fromJson(json.decode(userData.body)['support']).text);




      // print(data.lastName);

      if(userData.statusCode == 200){

        User user = User(
          userID: json.decode(userData.body)['data']['id'],
          firstName: json.decode(userData.body)['data']['first_name'],
          lastName: json.decode(userData.body)['data']['last_name'],
          email: json.decode(userData.body)['data']['email'],
          avatarUrl: json.decode(userData.body)['data']['avatar'],
          url: json.decode(userData.body)['support']['url'],
          text: json.decode(userData.body)['support']['text'],

        );





        return APIResponse(
          data: user,
          errorMessage: '', 
          error:  false
        );
      }
      return APIResponse(
          data: null,
          errorMessage: 'Error : ${userData.statusCode}',
          error:  false
      );
    }).catchError((error) {
      APIResponse(
          data: User(),
          errorMessage: 'Error: $error',
          error:  false
      );
    }); 

  }


}