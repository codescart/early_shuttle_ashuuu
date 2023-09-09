// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:early_shuttle/Constant/url.dart';
import 'package:http/http.dart' as http;
import '../../Constant/SharedPreference.dart';
import '../../Models/HomePage_Sections/ImageSlider_Model.dart';

Future<ImageSlider> fetchImageSliderData() async {
final String userId= SharedPreferencesUtil.getUserId();
  final String token = SharedPreferencesUtil.getUserAccessToken();

  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  final data = {
    "user_id":userId,
  };

  final url = Uri.parse(
      AppUrls.HomePageImageSliderApiUrl
  ); // Replace with your API endpoint

  try {
    final response = await http.post(
        url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      return ImageSlider.fromJson(jsonData);
    } else {
      throw Exception('Failed to load slider data');
    }
  } catch (error) {
    rethrow;
  }
}
