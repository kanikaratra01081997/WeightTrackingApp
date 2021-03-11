import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth=  FirebaseAuth.instance;

class RegisterEmail extends StatefulWidget {

// final const routeName = '/auth';

  @override
  _RegisterEmailState createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {


bool _success;
String _userEmail;
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

void _register() async
{
  final FirebaseUser user =  (await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)).user;
  if(user!=null)
  {
    setState(() {
         _success=true;
    _userEmail=user.email;
    });
 
  }
  else
  {
    setState(() {
      _success=true;
    });
  }


}

  final _formKey = GlobalKey<FormState>();//since we want to validate our result we need global key of form state.

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20),
                      child: TextFormField(
                controller:_emailController ,
                decoration: InputDecoration(
                  labelText: "Email",
                border: OutlineInputBorder(), 
                ),
                validator: (String value){
                  if(value.isEmpty)
                  {
                    return 'Please enter some text';
                  }
                  return null;
                },
            ),
          ),

          Divider(),

          Padding( padding: EdgeInsets.all(20),
                      child: TextFormField(controller: _passwordController,
            decoration: InputDecoration(
                  labelText: "Password",
                border: OutlineInputBorder(), 
                ),
                validator: (String value){
                  if(value.isEmpty)
                  {
                    return 'Please enter some text';
                  }
                  return null;
                },
            ),
          ),

          Divider(),

          Container(padding:EdgeInsets.all(10),
          alignment: Alignment.center,
          child: RaisedButton(child: Text('Submit'),
          onPressed: ()async{
            if(_formKey.currentState.validate())
            {
             _register();
            }
          },
          ),
          ),

          Container(alignment: Alignment.center,
          child: Text(_success==null? '': (_success? 'Successfully Registered'+_userEmail: 'Registeration failed for'+ _userEmail)),)

          // Add TextFormFields and ElevatedButton here.
        ]
     )
    );
  }


@override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }




}