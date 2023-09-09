// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:early_shuttle/Constant/url.dart';
import 'package:http/http.dart' as http;
import '../../Constant/SharedPreference.dart';
import '../../Models/HelpSection_Model/Call-Write_Model.dart';

Future<ContactUsModel?> fetchCallWriteUs() async {
  final String token = SharedPreferencesUtil.getUserAccessToken();

  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  final url = Uri.parse(AppUrls.helpCallWriteApiurl);
  try {
    final response = await http.get(
        url,
      headers: headers
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return ContactUsModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load contact info data');
    }
  } catch (error) {
   return null;
  }
}