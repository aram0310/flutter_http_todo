import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_todo/models/users.dart';
import 'package:my_todo/screens/user_details.dart';
import 'package:my_todo/services/api_response.dart';
import 'package:my_todo/services/user_services.dart';



class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  UsersServices get userService => UsersServices();

  List<Users> users = [];

  APIResponse _apiResponse = new APIResponse();


  bool isLoading = false;


  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 8, right: 8),

      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(

              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20),
          itemCount: users.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: (){
                Get.to(() => UserDetails(userID: users[index].userID,));
              },
              child: Container(

                alignment: Alignment.center,
                decoration: BoxDecoration(

                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.amberAccent.withOpacity(0.6),
                        Colors.deepOrange.withOpacity(0.6),

                      ],
                    ),
                    borderRadius: BorderRadius.circular(25)),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 42.0,
                      backgroundImage:
                      NetworkImage(users[index].avatarUrl),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 16,),
                    Text(users[index].firstName + " " + users[index].lastName),
                    Text(users[index].email),
                  ],
                ),

              ),
            );
          }),
    );
  }

  @override
  void initState() {

    setState(() {
      isLoading = true;
    });
     userService.getAllUsers().then((apiResp) {

       _apiResponse = apiResp;


      setState(() {
        users = apiResp.data;
        isLoading = false;
      });

      print(users);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],

        body: Builder(
        builder: (_) {

          if(isLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(_apiResponse.error){
            return Center(
              child: Text(
                _apiResponse.errorMessage
              ),
            );
          }else{
            return _buildContent();
          }
        },
      )
    );
  }
}
