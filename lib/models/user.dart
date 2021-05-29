class User {
  int userID;
  String firstName;
  String lastName;
  String email;
  String avatarUrl;
  String url;
  String text;


  User({this.userID, this.firstName, this.lastName, this.email, this.avatarUrl, this.text, this.url});


  factory User.fromJson(Map<String, dynamic> user){
    return User(
        userID: user['id'],
        firstName: user['first_name'],
        lastName: user['last_name'],
        email: user['email'],
        avatarUrl: user['avatar'],
        text: user['text'],
        url: user['url'],
    );
  }
}