


import 'package:flutter/material.dart';
import '../Data/AuthService.dart';
import '../Shared/InputDecoration.dart';
class SignInRegister extends StatefulWidget {

  final Function toggleView;
  SignInRegister({this.toggleView});
  @override
  _SignInRegisterState createState() => _SignInRegisterState();
}

class _SignInRegisterState extends State<SignInRegister> {

final Auth _authService = Auth();
final _formKey = GlobalKey<FormState>();

String email ="";
String password="";
String error="";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        elevation: 0.0,
        title: Text("Register"),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            onPressed: (){
                widget.toggleView();
          }, 
          label: Text("Signin"),
          )
        ],
      ),


body: Container(
  padding: EdgeInsets.all(20),
  child: Form(
    key: _formKey,
      child: Column(children: <Widget>[
      SizedBox(height:20.0),

      TextFormField(
        //  decoration: InputDecoration(
        //             labelText: "Register Email",
        //           border: OutlineInputBorder(), 
        //           ),
        decoration: textInputDecoration.copyWith(
          hintText:'email to register with',
        labelText: 'Email', 
        icon:Icon(Icons.email)
        ),
                  validator: (val){
                    if(val.isEmpty)
                    {
                      return "Enter text to register email";
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
              //       labelText: "Register Password",
              //     border: OutlineInputBorder(), 
              //     ),
              decoration: textInputDecoration.copyWith(
          hintText:'password used to register',
        labelText: 'Password', 
        icon:Icon(Icons.lock)
        ),
        obscureText: true,
        validator: (val){
          if(val.isEmpty)
          {
            return "Enter password to register";
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
        child: Text("Register"), 
      color: Colors.amber,
      onPressed: () async{

        if(_formKey.currentState.validate())
        {
         print(password);
        print(email);
          dynamic result = await _authService.registerEmailAndPassword(email, password);
          if(result==null)
          {
            setState(()=> error ='please enter valid email');
          }
     
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