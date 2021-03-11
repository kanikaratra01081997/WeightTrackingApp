import './SignInRegisterScreen.dart';
import './SignInViaEmailPassword.dart';
import 'package:flutter/material.dart';

class AuthenticationWidget extends StatefulWidget {
  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {

  bool showSignIn=true;

  void toggleView(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn)
    {
      return SignInViaEmailPass(toggleView:toggleView);
    }
    else
    {
      return SignInRegister(toggleView:toggleView);
    }
  }
  }