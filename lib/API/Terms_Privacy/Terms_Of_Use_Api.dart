// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:early_shuttle/Constant/url.dart';
import 'package:http/http.dart' as http;
import '../../Constant/SharedPreference.dart';
import '../../Models/Terms_Privacy/TermsofUser_Login_Model.dart';

Future<TermsOfUse> fetchTermsOfUseData() async {
  final url = Uri.parse(AppUrls.LoginTermsOfUseApiUrl);
  final String token = SharedPreferencesUtil.getUserAccessToken();

  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  try {
    final response = await http.get(
        url,
      headers: headers
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return TermsOfUse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    rethrow;
  }
}