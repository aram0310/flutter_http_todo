class Notes{
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  Notes({this.noteID, this.noteTitle, this.createDateTime, this.latestEditDateTime});

  factory Notes.fromJson(Map<String, dynamic> item){
    return Notes(
      noteID: item['noteID'],
      noteTitle: item['noteTitle'],
      createDateTime: DateTime.parse(item['createDateTime']),
      latestEditDateTime: item['latestEditDateTime'] != null
          ? DateTime.parse(item['latestEditDateTime'])
          : null,
    );
  }

}