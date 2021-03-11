
import 'package:MyMusicApp/Data/Model.dart';
import 'package:flutter/material.dart';
import '../Bloc/WeightBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Shared/InputDecoration.dart';
import '../Bloc/WeightEvent.dart';
 
 class ShowBottomSheet extends StatefulWidget {
 String uuid;
   ShowBottomSheet({@required uuid});
  @override
  _ShowBottomSheetState createState() => _ShowBottomSheetState(uuid);
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {

  String id="";
  double weight;
  String date ="";
  String uuid;


   _ShowBottomSheetState(uuid); 

 WeightBloc _weightBloc;

  @override
  Widget build(BuildContext context) {
      _weightBloc = BlocProvider.of<WeightBloc>(context);
    return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: TextButton(
                onPressed: (){showBottomSheetCustom(  context);},
               child: Text("click to add more", 
               style: TextStyle(backgroundColor: Colors.amber, 
               color: Colors.white, fontSize: 20),
              ),
              ),
            ) ;
    
  }


void showBottomSheetCustom(BuildContext context)
{
 showModalBottomSheet<void>( 
   context:context,
 builder: (BuildContext context) {
          return 
          Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(20), 
                  topRight: const Radius.circular(20)),
                ),
                padding: MediaQuery.of(context).viewInsets,
                child: Form(
                  child: Wrap(
              
                    children: <Widget>[
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter Weight',
                            labelText: 'Weight',
                            icon: Icon(Icons.sports_bar)),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enter an weight";
                          }
                          return null;
                        },
                        onChanged: (val ) {
                          setState(() {
                            weight = double.parse(val);
                          });
                        },
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter date',
                            labelText: 'date',
                            icon: Icon(Icons.sports_bar)),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "Enter date";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            date = val;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter id',
                            labelText: 'id',
                            icon: Icon(Icons.sports_bar)),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "id";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            id = val;
                          });
                        },
                      ),
                      Center(
                        child: ElevatedButton(
                          // color: Colors.amber,
                          // elevation: 6.0,
                          child: Text("Submit"),
                          onPressed: () async{
                            debugPrint(id.toString());
                            debugPrint(weight.toString());
                            debugPrint(weight.runtimeType.toString());
                            debugPrint(date.toString());
                            WeightEntryOfDay weightEntry= WeightEntryOfDay(date: date,id:id, weight:weight);
                    _weightBloc.add((WeightEventAdded( weightEntry, "jwfT39bE3XSzaLiq9TId5eAtfHj1" )
                    ));
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            
            // );
        
        }
        );
}




}