
// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:early_shuttle/Constant/url.dart';
import 'package:early_shuttle/Models/Pass_Section/Current_Pass_Model.dart';

import '../../Constant/SharedPreference.dart';

Future<CurrentPassListModel> fetchCurrentPassData() async {
  final url = Uri.parse(AppUrls.CurrentPassApiUrl);
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
  final responseData = json.decode(response.body);
  print(responseData);
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final purchasePassResponse = CurrentPassListModel.fromJson(responseData);
    return purchasePassResponse;
  } else {
    throw Exception("Failed to fetch purchase pass data");
  }
}