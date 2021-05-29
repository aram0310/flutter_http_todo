import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:my_todo/models/notes.dart';
import 'package:my_todo/services/api_response.dart';
import 'package:my_todo/services/todo_service.dart';

import 'modify_note.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TodoService get service => GetIt.I<TodoService>();

  APIResponse<List<Notes>> _apiResponse = APIResponse();

  bool isLoading = false;
  bool isBusy = false;


  _fetNotes() async {
    setState(() {
      isLoading = true;
    });

    _apiResponse = await service.geNotetList();

    setState(() {
      isLoading = false;
    });


  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }


  @override
  void initState() {
    _fetNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Get.to(() => ModifyNote(noteId: null)).then((value) => _fetNotes());
        },
        child: Icon(Icons.add),
      ),

      body: Container(
        padding: EdgeInsets.all(8.0),

        child: Builder(
          builder: (_) {
           if(isLoading){
             return Center(child: CircularProgressIndicator(),);
           } else if(_apiResponse.error) {
             return Center(child: Text(_apiResponse.errorMessage),);
           }else{
             return Container(
               child: ListView.builder(
                 itemCount: _apiResponse.data.length,
                 itemBuilder: (_, index) {
                   return Container(
                     child: ListTile(
                       title: Text(_apiResponse.data[index].noteTitle),
                       subtitle: Text(formatDateTime(_apiResponse.data[index].createDateTime)),
                       trailing: Icon(Icons.arrow_forward_ios_rounded),
                       onTap: (){
                         Get.to(() => ModifyNote(noteId: _apiResponse.data[index].noteID,));
                       },
                     ),
                   );
                 } ,
               ),
             );
           }
          },
        ),

      ),
    );

  }
}
