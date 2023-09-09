// ignore_for_file: file_names, depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'package:early_shuttle/Constant/url.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/HomePage.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Constant/SharedPreference.dart';

Future<void> UserRegistration(context,String PhoneNumber, String name, String email,
    String referal,String userId, String deviceId, String deviceName, String Model, ) async {
  const url = AppUrls.RegisterApiUrl;
  String token = SharedPreferencesUtil.getUserAccessToken();
  print(token);

  final data = {
    "phone":PhoneNumber,
    "name":name,
    "email":email,
    "model":Model,
    "devicename":deviceName,
    "os":deviceId,
    "user_id":userId,
    "referral_code":referal
  };

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    },
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    final UserData = json.decode(response.body);
    print(UserData);
    if (kDebugMode) {
      print(UserData);
    }
    final userID = UserData['user']['id'].toString();
    SharedPreferencesUtil.setUserId(userID);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Homepage()));
   // return Utils.toastMessage("User registerd successfully");
  } else {
    if (kDebugMode) {
      print('Error inserting data: ${response.statusCode}');
    }
  }
}
