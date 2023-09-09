// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../Constant/SharedPreference.dart';
import '../../Constant/url.dart';
import '../../Models/Profile_Model/ViewProfile_Model.dart';


Future<UserProfile> fetchProfileViewData() async {
  String userId = SharedPreferencesUtil.getUserId();
  final String token = SharedPreferencesUtil.getUserAccessToken();
if (kDebugMode) {
  print(userId);
}
  final url = Uri.parse(AppUrls.ProfileViewApiUrl);

  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  final data = {
    "user_id": userId,
    // 49093 my user id for 9565922753// 49098
  };

  final response = await http.post(
      url,
      headers: headers,
      body: json.encode(data)
  );
  final responseData = json.decode(response.body);
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (kDebugMode) {
      print(responseData);
    }
    return UserProfile.fromJson(responseData);
  } else {
    if (kDebugMode) {
      print(responseData);
    }
    throw Exception("Failed to fetch profile data");
  }
}


