// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:early_shuttle/Constant/url.dart';
import 'package:early_shuttle/Models/Pass_Section/T_C_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../Constant/SharedPreference.dart';

Future<PassT_C> fetchPassTCData() async {
  final url = Uri.parse(AppUrls.PassTermsCondidtionApiUrl);

  final String token = SharedPreferencesUtil.getUserAccessToken();



  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  try {
    final response = await http.get(
        url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'];
      if (kDebugMode) {
        print(jsonData);
      }
      return PassT_C.fromJson(jsonData);
    }
    else {
      throw Exception('Failed to load Terms and condition data');
    }
  } catch (error) {
    rethrow;
  }
}