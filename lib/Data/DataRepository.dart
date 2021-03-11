

import 'package:MyMusicApp/Data/Model.dart';

import './DataProvider.dart';
import 'package:flutter/material.dart';

 class DataRepo{
  
 final String uid;

 DataRepo({  @required this.uid});
    List<WeightEntryOfDay> loadedWeights ;

Future<List<WeightEntryOfDay>> getWeight () async
{
  print("called getWeight");
 //await WeightApiClient(uid).updateUserData(21,"rrr","ol");
//  await WeightApiClient(uid).appendUserDataToList("dd",34 , "56");

return  await WeightApiClient(uid).getUserData();
}


Future<void> appendingToList ( WeightEntryOfDay weightEntry) async
{
  print("called getWeight");
  return await WeightApiClient(uid).appendUserDataToList(weightEntry);

}


Future<void> deleteFromList (WeightEntryOfDay weightEntry) async{
  print(" dara repo call delete from provider");
  return await WeightApiClient(uid).deleteItemFromList(weightEntry.date, weightEntry.weight, weightEntry.id);
}


List<WeightEntryOfDay> saveWeights(List<WeightEntryOfDay> weightList){
    // List<WeightEntryOfDay> 
    loadedWeights = weightList;
    return loadedWeights;
 }


 List<WeightEntryOfDay> returnLoadedWeight(){
return loadedWeights;
 }



}







