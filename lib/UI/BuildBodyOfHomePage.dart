import 'package:MyMusicApp/Bloc/WeightBloc.dart';
import 'package:MyMusicApp/Bloc/WeightEvent.dart';
import 'package:MyMusicApp/UI/ListWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/Model.dart';
import '../Bloc/WeightEventState.dart';

// ignore: must_be_immutable
class BuildBodyOfHomePage extends StatelessWidget {
  String uuid;
  BuildBodyOfHomePage({@required this.uuid});
  List<WeightEntryOfDay> weightData = List();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _weightBloc = BlocProvider.of<WeightBloc>(context);
  
    // _weightBloc.add(GetWeightData(uid: "jwfT39bE3XSzaLiq9TId5eAtfHj1"));
    _weightBloc.add(WeightEventLoad("jwfT39bE3XSzaLiq9TId5eAtfHj1"));
    return BlocBuilder<WeightBloc, WeightState>(
      builder: (context, state) {
        if (state is WeightStateLoadFailure) {
          return Text(state.errorMessage);
        }
        if (state is  WeightStateLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is WeightStateLoadSuccess) {
          print(state.loadedWeight);
          weightData=(state.loadedWeight);
          debugPrint("using weight only");
          return (ListView.builder(
              itemCount: weightData.length,
              itemBuilder: (ctx, index) {
                return ListWidget(weightData[index]);}
                )
              );
        }
        return Text("initial");
      },
    );
  }
}
