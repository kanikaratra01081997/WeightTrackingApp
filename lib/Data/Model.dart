import 'dart:core';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';




class WeightEntryOfDay extends Equatable{
  final double weight;
  final String date;
  final String id;
  WeightEntryOfDay({@required this.weight, @required this.date, @required this.id});
  
   factory WeightEntryOfDay.fromJson(dynamic json)
  {
    return WeightEntryOfDay(date: json['date'],id: json['id'], weight: json['weight']);
   
  }


  @override
  String toString() {
    return '{ ${this.weight}, ${this.date}, ${this.id} }';
  }



    Map<String, dynamic> toJson() => {
        "weight": weight,
        "date": date,
        "id": id,
    };

  Map<String, dynamic> toArrayJson(dynamic data) => {
        "ListOfWeight": data,
    };



     WeightEntryOfDay toEntity() {
    return WeightEntryOfDay(weight: weight, id: id, date: date);
  }


    static WeightEntryOfDay fromEntity(WeightEntryOfDay entity) {
    return WeightEntryOfDay(
      id: entity.id,
      date: entity.date,
      weight: entity.weight,
    );
  }


List<WeightEntryOfDay> userFromJson(String str) => List<WeightEntryOfDay>.from(json.decode(str).map((x) => WeightEntryOfDay.fromJson(x)));
 String userToJson(List<WeightEntryOfDay> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


  static WeightEntryOfDay fromSnapshot(dynamic snap) {
    return WeightEntryOfDay(
      // snap.data['task'],
       weight: snap.data['weight'],
       id: snap.data['id'],
       date:snap.data['date'],
    );
  }




  @override
  List<Object> get props => [weight,date,id];
  }







// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// import 'dart:convert';

// List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

// String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class User {
//     User({
//         this.userId,
//         this.id,
//         this.title,
//         this.body,
//     });

//     int userId;
//     int id;
//     String title;
//     String body;

//     factory User.fromJson(Map<String, dynamic> json) => User(
//         userId: json["userId"],
//         id: json["id"],
//         title: json["title"],
//         body: json["body"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "id": id,
//         "title": title,
//         "body": body,
//     };
// }

