// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:early_shuttle/Constant/url.dart';
import '../../Constant/SharedPreference.dart';
import '../../Models/My_RidesSection/CurrentRides_Model.dart';

Future<CurrentRidesModel?> fetchCurrentRidesData() async {
  final url = Uri.parse(AppUrls.CurrentRideApiUrl);
  String userId = SharedPreferencesUtil.getUserId();

  final String token = SharedPreferencesUtil.getUserAccessToken();

  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  final data = {
    "user_id": userId,
  };

  final response = await http.post(
      url,
      headers: headers,
      body: json.encode(data)
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (kDebugMode) {
      print(responseData);
    }
      final purchasePassResponse = CurrentRidesModel.fromJson(responseData);
      return purchasePassResponse;
  } else {
    final responseData = json.decode(response.body);
    if (kDebugMode) {
      print(responseData);
    }
     if (kDebugMode) {
       print("Failed to fetch purchase pass data");
     }
     return null;
  }
}