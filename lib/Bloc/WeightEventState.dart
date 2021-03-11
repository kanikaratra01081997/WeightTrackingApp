
import '../Data/Model.dart';
import 'package:equatable/equatable.dart';



abstract class WeightState extends Equatable {
  const WeightState();
  @override
  List<Object> get props => [];
}

class WeightStateLoadInProgress extends WeightState {}

class WeightStateLoadSuccess extends WeightState {
  final List<WeightEntryOfDay> loadedWeight;
   WeightStateLoadSuccess(this.loadedWeight);
  @override
  List<Object> get props => [loadedWeight];
}

class WeightStateLoadFailure extends WeightState {
  final String errorMessage;
  WeightStateLoadFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];

}








// @immutable
// abstract class WeightState extends Equatable {}

// class InitialWeightState extends WeightState {
//   @override
//   List<Object> get props => [];
// }

// class WeightError extends WeightState {
//   final String errorMessage;
//   WeightError({this.errorMessage});
//   @override
//   List<Object> get props => [];
// }

// class WeightLoading extends WeightState {
//   @override
//   List<Object> get props => [];
// }

// class WeightLoaded extends WeightState {
//   final List<WeightEntryOfDay> loadedWeight;
//   WeightLoaded(this.loadedWeight);

//   @override
//   List<Object> get props => [loadedWeight];
// }

// -----------------------------