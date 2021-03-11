import 'package:flutter/material.dart';
import '../Data/AuthService.dart';
import '../Shared/InputDecoration.dart';
class SignInViaEmailPass extends StatefulWidget {
    final Function toggleView;
  SignInViaEmailPass({this.toggleView});
  @override
  _SignInViaEmailPassState createState() => _SignInViaEmailPassState();
}

class _SignInViaEmailPassState extends State<SignInViaEmailPass> {

final Auth _authService = Auth();

String email ="";
String password="";
String error="";

var _finalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        elevation: 0.0,
        title: Text("Sign in via Email Password "),
            actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: (){
                widget.toggleView();
          }, 
          label: Text("Register"),
          )
          ]
      ),


body: Container(
  padding: EdgeInsets.all(20),
  child: Form(
    key: _finalKey,
      child: Column(children: <Widget>[
      SizedBox(height:20.0),

      TextFormField(
        //  decoration: InputDecoration(
        //             labelText: "Email",
        //           border: OutlineInputBorder(), 
        //           ),
        decoration: textInputDecoration.copyWith(
          hintText:'Enter email to sign in your account',
        labelText: 'Email', 
        icon:Icon(Icons.email)
        ),
                  validator: (val){ if(val.isEmpty)
                  {
                    return "Enter an email";
                  }
                  return null;
                  },
        onChanged: (val){
          setState(() {
            email=val;
          });
        },
      ),

      SizedBox(height:20.0),

      TextFormField(
              //  decoration: InputDecoration(
              //       labelText: "Password",
              //     border: OutlineInputBorder(), 
              //     ),
              decoration: textInputDecoration.copyWith(
          hintText:'enter password to sign in your account',
        labelText: 'Password', 
        icon:Icon(Icons.email)
        ),
        obscureText: true,
        validator: (val){ if(val.isEmpty){
          return "Enter password";
        }
        if(val.length<6)
        {
          return "Enter more than 6 characters";
        }
        return null;
        },
        onChanged: (val){

            setState(() {
              password=val;
            });
        },
      ),


      SizedBox(height: 20.0,),

      RaisedButton(
        child: Text("Sign in"), 
      color: Colors.amber,
      onPressed: () async{
    if(_finalKey.currentState.validate()) // evaluate the result--boolean
    {

      dynamic result = await _authService.signInViaEmailPassword(email, password);
  if(result==null)
  {
    setState(()=> error=' wrong password bro');
  }

        print(password);
        print(email);


    }



      },),
      SizedBox(height:20.0),
       Text(error),




    ],
    ),
  )
),


    );
     
  }





}