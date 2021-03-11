
import 'package:firebase_auth/firebase_auth.dart';
import 'UserModel.dart';

class Auth
{
 final FirebaseAuth _auth = FirebaseAuth.instance;
 String uid;
 String firebaseuid;
 //Firebase User to custom User
 User firebaseUserToUser(FirebaseUser user)
  {
    if(user!=null)
    {
      return User(uid: user.uid);
    }
    return null;
  }


  // Auth change user Stream

//mapping of signed in signed out and mapping into our user.
Stream<User> get checkForUserStatus{
  return _auth.onAuthStateChanged.map((FirebaseUser user) => firebaseUserToUser(user));
}

Future signInAnon() async{

try{
AuthResult result= await _auth.signInAnonymously();
print(result);
FirebaseUser user = result.user;
firebaseuid=user.uid;
return firebaseUserToUser(user); // returning myinstance of user

}
catch(err){
  print(err.toString());
  return null;

}
}

//signOut

Future registerEmailAndPassword(String email, String pass) async
{
  try{
  AuthResult result = await  _auth.createUserWithEmailAndPassword(email: email, password: pass); //auth-firebase
    print(result);
    /// create dummy data for registered user

    FirebaseUser user= result.user;//ectract user from the result
    firebaseuid=user.uid;//get user's uid
      // await  WeightApiClient(firebaseuid).updateUserData(255, "1111", "09");
    return firebaseUserToUser(user); //my instance of user

  }
  catch(err){
    print(err.toString());
  }

}

Future signInViaEmailPassword(String email, String pass) async
{

 try{
  AuthResult result = await  _auth.signInWithEmailAndPassword(email: email,password: pass);//auth-firebase
    print(result);
    FirebaseUser user= result.user;//ectract user from the result
    firebaseuid=user.uid;//get user's uid
    //  await  WeightApiClient(firebaseuid).updateUserData(255, "1111", "09");
    return firebaseUserToUser(user); //my instance of user

  }
  catch(err){
    print(err.toString());
  }



}


Future signOutFromApp() async{
  try{
return await _auth.signOut();
  }
  catch(err)
  {
    print(err.toString());
    return null;
  }
 }
  returnFireBaseUser() async{
  return await  _auth.currentUser();

}


String  returnfirebaseuid(){
  return firebaseuid;
}

}