import 'package:MyMusicApp/Bloc/WeightBloc.dart';
import 'package:MyMusicApp/Data/AuthService.dart';
import 'package:MyMusicApp/Data/DataRepository.dart';
import 'package:MyMusicApp/Data/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BuildBodyOfHomePage.dart';
import './ShowbottomSheet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id = "";
  String date = "";
  double weight = 0.0;
  List<WeightEntryOfDay> weightData = List();
  Auth auth = Auth();
  String uuid;
  WeightBloc wbloc;
  DataRepo repo;

  // String firebaseuid=auth.returnfirebaseuid();

  
  @override
  void initState() {
    uuid = auth.returnfirebaseuid();
    print(uuid);
  print("uuid printing");
    // repo=DataRepo(uid:uuid);
    super.initState();
  }


  @override
  void dispose() {
    wbloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext mAppContext) {
    return
     Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text("home"),
        backgroundColor: Colors.amber[200],
        elevation: 0.0,
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
                onPressed: () async {
                  var user = await auth.returnFireBaseUser();
                  if (user == null) {
                    Scaffold.of(context).showSnackBar(const SnackBar(
                      content: Text("No user is signed in"),
                    ));
                    return;
                  }
                  await auth.signOutFromApp();
                  final String uid = user.uid;
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(uid + ' has successfully signed out.'),
                  ));
                },
                child: Text(
                  "Sign out",
                  style: TextStyle(color: Colors.white),
                ));
          })
        ],
      ),
      body: 
      BlocProvider(
        create: (BuildContext mAppContext)=>WeightBloc() ,
        child: Column(
          children: [
            Expanded(child: BuildBodyOfHomePage(uuid: uuid,)),
            ShowBottomSheet(uuid: uuid,),

            

          ],
        ),
      ),
    


    // floatingActionButton: BlocProvider(
    //   create: (context)=> FormBloc(), 
    //   child: ShowBottomSheet(),),
    );
  }



}
