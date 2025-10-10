// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class PredictionModel {
  double price;
  DateTime timeStamp;
  PredictionModel({
    required this.price,
    required this.timeStamp,
  });
  
  // PredictionModel({
  //   required this.price,
  //   required this.timeStamp,
  // });

  // PredictionModel copyWith({
  //   double? price,
  //   String? timeStamp,
  // }) {
  //   return PredictionModel(
  //     price: price ?? this.price,
  //     timeStamp: timeStamp ?? this.timeStamp,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'price': price,
  //     'timeStamp': timeStamp,
  //   };
  // }

  // factory PredictionModel.fromMap(Map<String, dynamic> map) {
  //   return PredictionModel(
  //     price: map['price'] as double,
  //     timeStamp: map['timeStamp'] as String,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory PredictionModel.fromJson(Map<String, dynamic> json) {
  //   return PredictionModel(
  //     price: json['price'] as double, // Make sure 'price' is not null in JSON
  //     timeStamp: DateTime.parse(json['timestamp']) as DateTime? ??
  //         '', // Handle null case by providing a default value
  //   );
  // }

  // @override
  // String toString() => 'PredictionModel(price: $price, timeStamp: $timeStamp)';

  // @override
  // bool operator ==(covariant PredictionModel other) {
  //   if (identical(this, other)) return true;

  //   return other.price == price && other.timeStamp == timeStamp;
  // }

  // @override
  // int get hashCode => price.hashCode ^ timeStamp.hashCode;
  // static DateTime _parseTimeStamp(String timeStamp) {
  //   // Define the date format expected in the timeStamp string
  //   final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  //   // Parse the timeStamp string using the defined format
  //   return dateFormat.parse(timeStamp);
  // }

  PredictionModel copyWith({
    double? price,
    DateTime? timeStamp,
  }) {
    return PredictionModel(
      price: price ?? this.price,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'timeStamp': timeStamp.millisecondsSinceEpoch,
    };
  }

  factory PredictionModel.fromMap(Map<String, dynamic> map) {
    return PredictionModel(
      price: map['price'].toDouble(),
      timeStamp: DateTime.parse(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PredictionModel.fromJson(String source) => PredictionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PredictionModel(price: $price, timeStamp: $timeStamp)';

  @override
  bool operator ==(covariant PredictionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.price == price &&
      other.timeStamp == timeStamp;
  }

  @override
  int get hashCode => price.hashCode ^ timeStamp.hashCode;
}
