import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import './Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeightApiClient {
  final String uid;
  WeightApiClient(this.uid);
  Map<String, dynamic> weightOfTheDay;

  final CollectionReference weightCollection = Firestore.instance.collection( "Weights");
   //if doesn't exists create and get reference of the collection.

  Future<dynamic> updateUserData(double weight, var date, String id) async {

         // var logger = Logger();
      // logger.i("logging to get user data");
    print("updating user data");
    WeightEntryOfDay weightEntry = WeightEntryOfDay(date: date, weight: weight, id: id);
    //weight Model - { 24.0, 25/02/2021, 05 }

    weightOfTheDay = weightEntry.toJson(); 
    //json format- {weight: 24.0, date: 25/02/2021, id: 05}

    dynamic listUsingField = FieldValue.arrayUnion([weightOfTheDay]);
     // Array having json object

    Map<String, dynamic> jsonOfList = weightEntry.toArrayJson(listUsingField); 
    // jsonOfList having data in json format {ListOfWeight: Instance of 'FieldValue'} -> ListOfWeights: [{json1, json2 }]
    
    return await weightCollection.document(uid).setData(jsonOfList);
  }


  Future<List<WeightEntryOfDay>> getUserData() async {
    try {
      // print("get user data");
      var documentFromFirestore = await weightCollection.document(uid).get();
     
      DocumentSnapshot documentSnapshot = documentFromFirestore; 
      // Data returned is in the form of document snapshot
     
      dynamic jsonDocument = documentSnapshot.data;
     // the data property has the list of json stored- {ListOfWeight: [{date: 25/02/2021, weight: 24.0, id: 05},
     // {date: 22/02/2021, weight: 56.0, id: 07}]}
     
     
      List valueCorrespondingToList = Map<String, dynamic>.from(jsonDocument)['ListOfWeight'];
      // to get value corresponding to ListOfWeight: [{date: 25/02/2021, weight: 24.0, id: 05}, 
      //{date: 22/02/2021, weight: 56.0, id: 07}] 
      // this is  array of list of json

      List<dynamic> weightObject = valueCorrespondingToList
          .map<WeightEntryOfDay>((e) => (WeightEntryOfDay.fromJson(e)))
          .toList();
          // need to map each to weight model , so that we can use it 
          // [{ 24.0, 25/02/2021, 05 }, { 56.0, 22/02/2021, 07 }]
     return (weightObject);

    }
     catch (err) {
      print(err.toString());
    }
    return ([WeightEntryOfDay(weight: 00, date: "dd/mm/yyyy", id: "01")]);
  }

  Future<void> appendUserDataToList(WeightEntryOfDay weightEntry) async {

    print("appending data");
    weightOfTheDay = weightEntry.toJson();
     //json format of the field need to be added {weight: 23.0, date: 23/02/2021, id: 06}

    dynamic val = FieldValue.arrayUnion([weightOfTheDay]);
    // array value in firestore updated using FieldValue

    Map<String, dynamic> elementToBeAddedInArray = weightEntry.toArrayJson(val);
    // Json is updated  in firestore , ListOfWeights:[{json},{json}]
    await weightCollection
        .document(uid)
        .updateData(elementToBeAddedInArray)
        .then((value) => print("data updated"))
        .catchError((error) => print(error.toString()));
  }


  Future<void> deleteItemFromList(String date, double weight, String id) async {
    print("deleting item");
    WeightEntryOfDay weightEntry = WeightEntryOfDay(date: date, weight: weight, id: id);
   //weight model

    Map<String, dynamic> entryInJson = weightEntry.toJson();
    // weight model into Json because we need to remove json from array of json.

    dynamic val = FieldValue.arrayRemove([entryInJson]);
    // FieldValue used in firsore to update /delete from arrays

    Map<String, dynamic> elementToBeDeleted = weightEntry.toArrayJson(val);
    //because json is updated ListOfWeights:[{json},{json}]

    await weightCollection
        .document(uid)
        .updateData(elementToBeDeleted)
        .then((value) => print("deleted successfully"))
        .catchError((error, stacktrace) {
      print(error.toString());
      print(stacktrace);
    });
  }


}
