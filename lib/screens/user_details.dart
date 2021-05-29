import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_todo/models/user.dart';
import 'package:my_todo/services/api_response.dart';
import 'package:my_todo/services/user_services.dart';

class UserDetails extends StatefulWidget {
  int userID; 
  UserDetails({this.userID});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  UsersServices get userService => GetIt.I<UsersServices>();

  APIResponse<User> _apiResponse = APIResponse();

  bool isLoading = false;


  _buildUserProfile() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 74.0,
            backgroundImage:
            NetworkImage(_apiResponse.data.avatarUrl),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(height: 32,),
          Text(_apiResponse.data.firstName + " " + _apiResponse.data.lastName),
          Text(_apiResponse.data.email),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_apiResponse.data.url),
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(_apiResponse.data.text),
          ),

        ],
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    userService.getUser(widget.userID).then((apiRes) {
     setState(() {
       _apiResponse = apiRes;
       isLoading = false;
     });
    }) ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context) {
          if(isLoading) {
            return Center(child: CircularProgressIndicator(),);
          }else{
            return _buildUserProfile();
          }
        },
      ),
    );
  }
}
