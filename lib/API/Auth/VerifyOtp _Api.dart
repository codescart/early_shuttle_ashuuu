// ignore_for_file: file_names, depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'package:early_shuttle/Constant/SharedPreference.dart';
import 'package:early_shuttle/Constant/url.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/HomePage.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../User Interface/Screens/Authentication/Registration/Registration_Page.dart';

Future<void> OtpVerification(context, Otp, PhoneNumber, bool isRegisterd, String userID) async {

  const url = AppUrls.VerifyOtpApiUrl;

  final data = {
    "phone":PhoneNumber,
    "enteredOtp":Otp
  };

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    final UserData = json.decode(response.body);
    print(UserData);
    if (kDebugMode) {
      print(UserData);
    }
    final token = UserData['accessToken'];
    if (kDebugMode) {
      print(token);
    }
    SharedPreferencesUtil.setUserAccessToken(token);
    if (kDebugMode) {
      print(SharedPreferencesUtil.getUserAccessToken());
    }
    if(UserData['success']==false){
      return Utils.flushBarErrorMessage(UserData["message"], context);
    }
    else{
      if(isRegisterd == true){
        SharedPreferencesUtil.setUserId(userID);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homepage(navigation: "1",)));
        // return Utils.toastMessage("Login successfully");
      }
     else{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>RegistrationPage(phoneNumber:PhoneNumber, userId:userID
            )));
        // return Utils.flushBarErrorMessage("User not registerd", context);
      }
    }
  }
  else {
    if (kDebugMode) {
      print('Error inserting data: ${response.statusCode}');
    }
  }
}
