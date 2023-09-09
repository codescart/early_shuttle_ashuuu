// ignore_for_file: depend_on_referenced_packages, file_names

import 'dart:convert';
import 'package:early_shuttle/Constant/SharedPreference.dart';
import 'package:early_shuttle/Constant/url.dart';
import 'package:early_shuttle/Models/HomePage_Sections/Text_Slider_Model.dart';
import 'package:http/http.dart' as http;
import '../../Constant/global_call.dart';
import '../../User Interface/Screens/Home Page/HomePage.dart';
import '../../main.dart';

Future<BannerResponse?> fetchBannerData() async {

  final url = Uri.parse(AppUrls.HomePageTextBannerApiUrl);
  final String token = SharedPreferencesUtil.getUserAccessToken();

  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  try {
    final response = await http.post(
        headers: headers,
        url
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data= BannerResponse.fromJson(jsonData);
      return data;
    } else {
      throw Exception('Failed to load banner data');
    }
  } catch (error) {
   return null;
  }
}
