// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:early_shuttle/Constant/SharedPreference.dart';
import 'package:early_shuttle/Constant/global_call.dart';
import 'package:http/http.dart' as http;
import '../../Constant/url.dart';
import '../../Models/HomePage_Sections/Notification_Model.dart';
import '../../User Interface/Screens/Home Page/HomePage.dart';
import '../../main.dart';

Future<NotificationResponse?> fetchNotifications() async {
  final url = Uri.parse(AppUrls.NotificatinApiUrl);

  final String token = SharedPreferencesUtil.getUserAccessToken();
  String userId = SharedPreferencesUtil.getUserId();

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
    print(responseData);
    final notificationResponse = NotificationResponse.fromJson(responseData);
    // NotificationCount = responseData["count"];
    // print(GlobalCallClass.NotificationCount);
    return notificationResponse;
  } else {
    final responseData = json.decode(response.body);
    if(responseData['message'].toString().toLowerCase()=="invalid access token"){
      SharedPreferencesUtil.clearUserId();
    }
    return null;
  }
}