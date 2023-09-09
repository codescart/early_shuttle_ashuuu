// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Constant/SharedPreference.dart';
import '../../Constant/url.dart';
import '../../Models/Explore_Route/ExploreRoute_Model.dart';

Future<List<ExploreRoute>> fetchExploreRouteData() async {
  final String token = SharedPreferencesUtil.getUserAccessToken();
  final String userId= SharedPreferencesUtil.getUserId();

  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  final data = {
    "user_id":userId
  };

  final response = await http.post(
      Uri.parse(AppUrls.ExploreRouteApiUrl),
    headers: headers,
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body)['data'];
    print(data);
    List<ExploreRoute> routes = data.map((route) => ExploreRoute.fromJson(route)).toList();
    return routes;
  } else {
    throw Exception('Failed to load data');
  }
}