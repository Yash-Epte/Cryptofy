import 'dart:convert';

import 'package:crytojay/models/coins_model.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'coins_provider.g.dart';

//flutter pub run build_runner watch
final dio = Dio();
String localUrl = "http://10.0.2.2:5000";

@riverpod
Future<List<Coins>> getCoins(GetCoinsRef ref) async {
  try {
    final response = await dio.get('$localUrl/coin_list');
    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          response.data; // Assuming response.data is already decoded JSON
      final List<Coins> coinsList =
          jsonData.map((coinData) => Coins.fromMap(coinData)).toList();
      return coinsList;
    } else {
      throw Exception("Failed to load data");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}

@riverpod
Future<Map<String, dynamic>> getPredictData(
  GetPredictDataRef ref, {
  required String coinName,
  required fromTime,
  required endTime,
}) async {
  try {
    Map<String, dynamic> body = {"coin_id": coinName,"start": fromTime, "till" : endTime};
    final response =
        await dio.post('$localUrl/predict', data: jsonEncode(body));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData =
          response.data; // Assuming response.data is already decoded JSON

      return jsonData;
    } else {
      throw Exception("Failed to load data");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}

@riverpod
Future<Map<String, dynamic>> getMontlyData(
  GetMontlyDataRef ref, {
  required String coinName,
  
}) async {
  try {
    Map<String, dynamic> body = {"coin_id": coinName,};
    final response =
        await dio.post('$localUrl/month', data: jsonEncode(body));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData =
          response.data; // Assuming response.data is already decoded JSON

      return jsonData;
    } else {
      throw Exception("Failed to load data");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}

@riverpod
Future<Map<String, dynamic>> getDailyData(
  GetDailyDataRef ref, {
  required String coinName,
  
}) async {
  try {
    Map<String, dynamic> body = {"coin_id": coinName,};
    final response =
        await dio.post('$localUrl/daily', data: jsonEncode(body));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData =
          response.data; // Assuming response.data is already decoded JSON

      return jsonData;
    } else {
      throw Exception("Failed to load data");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}


@riverpod
Stream<List<Coins>> getStreamCoins(GetStreamCoinsRef ref) async* {
  try {
    final response = await dio.get('$localUrl/coin_list');
    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          response.data; // Assuming response.data is already decoded JSON
      final List<Coins> coinsList =
          jsonData.map((coinData) => Coins.fromMap(coinData)).toList();
      yield coinsList;
    } else {
      throw Exception("Failed to load data");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
