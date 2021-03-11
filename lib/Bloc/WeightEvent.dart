
import 'package:MyMusicApp/Data/Model.dart';
import 'package:equatable/equatable.dart';

// @immutable
// abstract class WeightEvent {}

// class GetWeightData extends WeightEvent {
//   final String uid;
//   GetWeightData({@required this.uid});
// }

// class UpdateExistingList extends WeightEvent{
//   final String uid;
//   final String id;
//   final String date;
//   final double weight;
//   UpdateExistingList({@required this.uid, this.weight, this.date, this.id});

// }




abstract class WeightEvent extends Equatable {
  const WeightEvent();

  @override
  List<Object> get props => [];
}

class WeightEventLoad extends WeightEvent {
 final String uid;
  const WeightEventLoad(this.uid);
  @override
  List<Object> get props=>[ uid ];
} //get

class WeightEventAdded extends WeightEvent {
  final WeightEntryOfDay weightEntry;
  final String uid;

  const WeightEventAdded(this.weightEntry , this.uid);

  @override
  List<Object> get props => [weightEntry,uid];
}

class WeightEventUpdated extends WeightEvent {
  final WeightEntryOfDay weightEntry;
  final String uid;

  const WeightEventUpdated(this.weightEntry, this.uid);

  @override
  List<Object> get props => [weightEntry 
  , uid
  ];
}

class WeightEventDeleted extends WeightEvent {
  final WeightEntryOfDay weightEntry;
  final uid;
  const WeightEventDeleted(this.weightEntry , this.uid);
  @override
  List<Object> get props => [weightEntry ,uid];

}
