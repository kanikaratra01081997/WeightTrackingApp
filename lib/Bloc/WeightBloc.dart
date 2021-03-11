import 'package:MyMusicApp/Bloc/WeightEvent.dart';
import 'package:MyMusicApp/Bloc/WeightEventState.dart';
import 'package:MyMusicApp/Data/DataRepository.dart';
import 'package:MyMusicApp/Data/Model.dart';
import 'package:bloc/bloc.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  //  DataRepo dataRepository= DataRepo(uid:Auth().returnfirebaseuid());

  WeightBloc(): super(WeightStateLoadInProgress());

  @override
  Stream<WeightState> mapEventToState(WeightEvent event) async* {
    if (event is WeightEventLoad) {
      yield* _mapTodosLoadedToState(event);
    } else if (event is WeightEventAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is WeightEventUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is WeightEventDeleted) {
      yield* _mapTodoDeletedToState(event);
    }
  }

  Stream<WeightState> _mapTodosLoadedToState(
      WeightEventLoad event) async* {
    try {
      DataRepo dataRepo = DataRepo(uid: event.uid);
      final weights = await dataRepo.getWeight();
      print("printing weights");
      print(weights);
      yield WeightStateLoadSuccess(
        weights.map((ele) => WeightEntryOfDay.fromEntity(ele)).toList(),
      );
    } catch (error) {
      yield WeightStateLoadFailure(error.toString());
    }
  }

  Stream<WeightState> _mapTodoAddedToState(WeightEventAdded event) async* {
    if (state is WeightStateLoadSuccess) {
      DataRepo dataRepo = DataRepo(uid: event.uid);
      await dataRepo.appendingToList(event.weightEntry);
      print("appending");
      print(event.weightEntry);
      final List<WeightEntryOfDay> updatedTodos =
          List.from((state as WeightStateLoadSuccess).loadedWeight)
            ..add(event.weightEntry);
      yield WeightStateLoadSuccess(updatedTodos);
    }
  }

  Stream<WeightState> _mapTodoUpdatedToState(WeightEventUpdated event) async* {
    if (state is WeightStateLoadSuccess) {
      final List<WeightEntryOfDay> updatedTodos =
          (state as WeightStateLoadSuccess).loadedWeight.map((entryWeight) {
        return entryWeight.id == event.weightEntry.id
            ? event.weightEntry
            : null;
      }).toList();
      yield WeightStateLoadSuccess(updatedTodos);
    }
  }
  //delete

  Stream<WeightState> _mapTodoDeletedToState(WeightEventDeleted event) async* {
    if (state is WeightStateLoadSuccess) {
      DataRepo dataRepo = DataRepo(uid: event.uid);
      await dataRepo.deleteFromList(event.weightEntry);

      print((state as WeightStateLoadSuccess).loadedWeight);
      final List<WeightEntryOfDay> updatedWeights =
          (state as WeightStateLoadSuccess)
              .loadedWeight
              .where((element) => element != event.weightEntry)
              .toList();

      print("The list where an item is removed");
      if (updatedWeights == (state as WeightStateLoadSuccess).loadedWeight) {
        print("true");
      }
      print(updatedWeights);

      yield WeightStateLoadSuccess(updatedWeights);
    }
  }
}

// class WeightBloc extends Bloc<WeightEvent, WeightState>{

// List<WeightEntryOfDay> weightData;
// WeightBloc():super(InitialWeightState());

//   WeightState get initialState => InitialWeightState();

//   @override
//   Stream<WeightState> mapEventToState(WeightEvent event) async* {
//     if(event is GetWeightData)
//     {
// DataRepo dataRepo = DataRepo(uid:event.uid);
//     print("try block");
//       try {
//         yield WeightLoading();
//         print("loading");
//        weightData = await dataRepo.getWeight();
//        print("loaded get");
//        print(weightData);
//         yield WeightLoaded(weightData);

//       }catch( error)
//         {
//           yield WeightError(errorMessage:error.toString());
//         }
//     }

//   if(event is UpdateExistingList)
//   {
//          DataRepo dataRepo = DataRepo(uid:event.uid);
//          print("try block");
//       try {
//         yield WeightLoading();
//         print("loading");

//         WeightEntryOfDay newEntry = WeightEntryOfDay(date:event.date,id:event.id,weight: event.weight);

//       await dataRepo.appendingToList(event.id,event.date,event.weight);
//       final List<WeightEntryOfDay> updatedData = List.from(weightData)..add(newEntry);
//       yield WeightLoaded(updatedData);
//       // _saveTodos(updatedTodos);

//       }catch( error)
//         {
//           yield WeightError(errorMessage:error.toString());
//         }

//   }

//   }

// }

// Stream<WeightState> _mapToggleAllToState() async* {
//   if (state is TodosLoadSuccess) {
//     final allComplete =
//         (state as TodosLoadSuccess).todos.every((todo) => todo.complete);
//     final List<Todo> updatedTodos = (state as TodosLoadSuccess)
//         .todos
//         .map((todo) => todo.copyWith(complete: !allComplete))
//         .toList();
//     yield TodosLoadSuccess(updatedTodos);
//     _saveTodos(updatedTodos);
//   }
// }

// Stream<TodosState> _mapClearCompletedToState() async* {
//   if (state is TodosLoadSuccess) {
//     final List<Todo> updatedTodos =
//         (state as TodosLoadSuccess).todos.where((todo) => !todo.complete).toList();
//     yield TodosLoadSuccess(updatedTodos);
//     _saveTodos(updatedTodos);
//   }
// }

// List<WeightEntryOfDay> _saveTodos(List<WeightEntryOfDay> weightEntry) {
//      DataRepo dataRepo = DataRepo(
//        //uid:event.uid
//        );
//   return dataRepo.saveWeights(
//     weightEntry.map((oneEntry) => oneEntry.toEntity()).toList(),
//   );
// }
