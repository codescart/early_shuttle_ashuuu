// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'package:early_shuttle/Constant/url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../Constant/SharedPreference.dart';

Future<Map<String, dynamic>?> MakeOrderForPurchasePass(
    String amount, String urouteId,
    String drouteId, String passType,
    String paymentType, String promocode,
    String totalAmount
    ) async {

  String userId = SharedPreferencesUtil.getUserId();
  const url = AppUrls.GetBookingTranscationApiUrl;

  final String token = SharedPreferencesUtil.getUserAccessToken();

  final headers = {
    'Authorization': 'Bearer $token',
    "Content-Type": "application/json",
  };

  final data = {
    "user_id":userId,
    "amount":amount,
    "device":"ios",
    "uroute_id":urouteId,
    "droute_id":drouteId,
    "is_updated":"1",
    "pass_type":passType,
    "payment_type":paymentType,
    "promoCode":promocode,
    "total_amount":totalAmount

  };

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    final  UserData = json.decode(response.body);
    if (kDebugMode) {
      print(UserData);
    }
    return UserData;
  } else {
    if (kDebugMode) {
      print('Error inserting data: ${response.statusCode}');
      return null;
    }
  }
  return null;
}
