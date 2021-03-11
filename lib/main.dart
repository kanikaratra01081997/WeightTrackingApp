import 'package:MyMusicApp/Data/AuthService.dart';
import 'package:MyMusicApp/UI/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import './Data/UserModel.dart';




final FirebaseAuth _auth = FirebaseAuth.instance;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'My music app',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   home: MyHomePage(title: 'Flutter auth Home Page'),
    // );
    return MyHomePage();
  }
}

class MyHomePage extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
          home: StreamProvider<User>.value(
        value: Auth().checkForUserStatus,
        child: Wrapper(),
        ),

    );

  }
}
