
import 'package:MyMusicApp/Data/UserModel.dart';
import 'package:MyMusicApp/UI/AuthenticateStateOfWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './HomeScreen.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final userInfo = Provider.of<User>(context);
    print(userInfo);
    if(userInfo==null)
    {
     return  AuthenticationWidget();

    }
    return HomePage();
    // return HomePage();
  }
}