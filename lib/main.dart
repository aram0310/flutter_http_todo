import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:my_todo/screens/home_screen.dart';
import 'package:my_todo/screens/users_list.dart';
import 'package:my_todo/services/todo_service.dart';
import 'package:my_todo/services/user_services.dart';


void setupLocator() {
  GetIt.I.registerFactory(() => TodoService());
  GetIt.I.registerFactory(() => UsersServices());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.pink,
        ),
        home: Home(),
      ),
    );
  }
}


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  TodoService get service => GetIt.I<TodoService>();
  UsersServices get userService => GetIt.I<UsersServices>();

  _loadUsersData() async {}
  _loadTodoData() async {

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(''),
            //centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.today),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
            //backgroundColor: Colors.purple,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ Colors.purple, Colors.lightBlueAccent, Colors.greenAccent],
                  begin: Alignment.topRight,

                  end: Alignment.bottomLeft,
                ),
              ),
            ),
            bottom: TabBar(
              //isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                // Tab(icon: Icon(Icons.star), text: 'Feed'),
                Tab(icon: Icon(Icons.face), text: 'Profile'),
                // Tab(icon: Icon(Icons.settings), text: 'Settings'),
              ],
            ),
            elevation: 20,
            titleSpacing: 20,
          ),
        body: TabBarView(
          children: [
            HomeScreen(),
            UsersList()
          ],
        ),
      ),
    );
  }
}

