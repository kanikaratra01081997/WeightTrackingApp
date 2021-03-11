import 'package:MyMusicApp/Bloc/WeightBloc.dart';
import 'package:MyMusicApp/Bloc/WeightEvent.dart';
import 'package:MyMusicApp/Data/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ignore: must_be_immutable
class ListWidget extends StatelessWidget {
  final WeightEntryOfDay weightEntry;
  String date;
  String id;
  double weight;
  ListWidget(this.weightEntry);

  @override
  Widget build(BuildContext context) {

   // ignore: close_sinks
   final _weightBloc = BlocProvider.of<WeightBloc>(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        // color: ,
        clipBehavior: Clip.antiAlias,
      shadowColor: Colors.black,
      elevation: 5,
      child: ListTile(
        leading: Icon(Icons.sports_handball ),
        title: Text('The Weight as of now is ${weightEntry.weight.toString()}'),
        subtitle:Text(weightEntry.date) ,
        trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
          _weightBloc.add(WeightEventDeleted(weightEntry, "jwfT39bE3XSzaLiq9TId5eAtfHj1"));
        
        }),

      ),
      )
      
    );

  }
}