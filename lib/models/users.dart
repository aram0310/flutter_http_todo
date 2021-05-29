class Users{
  int userID;
  String firstName;
  String lastName;
  String email;
  String avatarUrl;


  Users({this.userID, this.firstName, this.lastName, this.email, this.avatarUrl});


  factory Users.fromJson(Map<String, dynamic> user){
    return Users(
      userID: user['id'],
      firstName: user['first_name'],
      lastName: user['last_name'],
      email: user['email'],
      avatarUrl: user['avatar']
    );
  }
}

