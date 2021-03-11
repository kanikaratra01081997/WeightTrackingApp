import 'package:flutter/material.dart';
import '../Data/AuthService.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final Auth _authService = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in "),
      ),


body: Container(
  padding: EdgeInsets.all(20),
  child: RaisedButton(child: Text("Sign in Anonymously"),
  onPressed:() async{
   dynamic isSignInAnonymousSuccessfull= await _authService.signInAnon();
   if(isSignInAnonymousSuccessfull==null)
   {
     print("error signin");
   }
   else
   {
     print("successful");
   }

  } ,
  ),
),


    );
     
  }





}