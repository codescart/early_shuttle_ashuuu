// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, duplicate_ignore
import 'dart:convert';
import 'package:early_shuttle/Constant/url.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../User Interface/Screens/Authentication/OTP Verification/OTP_Page.dart';
import '../../Utils/message_utils.dart';

Future<void> UserLogin(context,String PhoneNumber,) async {
  const url = AppUrls.LoginApiUrl;

  final data = {
    "phone":PhoneNumber
  };
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );
  bool isRegisterd;
  if (response.statusCode == 200) {
    // ignore: non_constant_identifier_names
    final UserData = json.decode(response.body);
    print(UserData);
    final userId= UserData['user']['id'].toString();
    if (kDebugMode) {
      print("userid is here");
      print(userId);
    }
    if(UserData['user']['name']==null && UserData['user']['email']==null){
      isRegisterd = false;
    }
    else{
    isRegisterd=true;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> opt_page(PhoneNumber: PhoneNumber, isRegisterd:isRegisterd, userId:userId)
    ));
    return Utils.toastMessage(UserData['message']);
  } else {
    if (kDebugMode) {
      return Utils.flushBarErrorMessage("Failed to sent OTP", context);
    }
  }
}