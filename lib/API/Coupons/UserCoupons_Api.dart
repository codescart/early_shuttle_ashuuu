// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Constant/SharedPreference.dart';
import '../../Constant/url.dart';
import '../../Models/CouponsModel/UserCoupons_Model.dart';


Future<CouponResponse?> fetchUserCouponsData() async {
  final url = Uri.parse(AppUrls.UserCouponsApiUrl);
  final String token = SharedPreferencesUtil.getUserAccessToken();
  final String userId= SharedPreferencesUtil.getUserId();

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
    if (responseData['msg'] == "Coupons list successful.") {
      // Coupons found, return CouponResponse
      final couponData = CouponResponse.fromJson(responseData);
      return couponData;
    } else {
      return CouponResponse(status: 0, msg: responseData['msg'], data: []);
    }
  } else {
    return null;
  }
}