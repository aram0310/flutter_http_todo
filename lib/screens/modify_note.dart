import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_todo/models/new_note.dart';
import 'package:my_todo/services/todo_service.dart';

class ModifyNote extends StatefulWidget {
  String noteId;

  ModifyNote({@required this.noteId,});

  @override
  _ModifyNoteState createState() => _ModifyNoteState();
}

class _ModifyNoteState extends State<ModifyNote> {
  TextEditingController _title = new TextEditingController();
  TextEditingController _content = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TodoService get service => GetIt.I<TodoService>();


  bool isBusy = false;

  bool get isEditing => widget.noteId != null;




  @override
  void initState() {
    // TODO: implement initState

    if(isEditing){
      setState(() {
        isBusy = true;
      });
        service.geNote(widget.noteId).then((data) {
          print(data.data);
          _title.text = data.data.noteTitle;
          _content.text = data.data.noteContent;
        }).then((value) {
        setState(() {
          isBusy = false;
        });
        });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isBusy ? Center(child: CircularProgressIndicator(),) : Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: _title,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: 'Title'
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _content,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: 'description'
                ),
              ),


              SizedBox(height: 16,),
              ElevatedButton(onPressed: buttonPressed, child: Text("${isEditing? 'Edit Note' : 'Create Note'}"))
            ],
          ),
        ),
      ),
    );
  }

  void buttonPressed() async {

      if(isEditing ){
        // update note
      }
      else{
        // new note
        if(_formKey.currentState.validate()){
          NewNote note = new NewNote(noteTitle: _title.text, noteContent: _content.text);
          setState(() {
            isBusy = true;
          });

        final result =  await service.createNote(note);

          if(result.data){
            Get.snackbar('Done', 'Successfully added note');
            _content.text = '';
            _title.text = '';
          }else{
            Get.snackbar('Something went wrong', '${result.errorMessage}');
          }

          setState(() {
            isBusy = false;
          });

        }

      }
  }
}
