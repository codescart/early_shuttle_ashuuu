// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:early_shuttle/Models/Pass_Section/Purchase_Pass_Model.dart';
import 'package:http/http.dart' as http;
import '../../Constant/SharedPreference.dart';
import '../../Constant/url.dart';

Future<List<RouteResponse>> fetchPurchaseData() async {
  final url = Uri.parse(AppUrls.PassPurchaseApiUrl);

  final String token = SharedPreferencesUtil.getUserAccessToken();
  final String userId= SharedPreferencesUtil.getUserId();
print(userId);

  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  final data = {
    "user_id":userId
  };

  final response = await http.post(
      url,
      headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    print(data);
    return data.map((json) => RouteResponse.fromJson(json)).toList();
  }  else {
    throw Exception("Failed to fetch purchase pass data");
  }
}