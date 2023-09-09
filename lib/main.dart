// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:early_shuttle/Constant/SharedPreference.dart';
import 'package:early_shuttle/Constant/getDeviceInfo.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/HomePage.dart';
import 'package:flutter/material.dart';
import 'User Interface/Screens/Authentication/Login Page/LoginPage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtil.init();
  runApp( const MyApp());
}

var height;
var width;

class MyApp extends StatefulWidget {
  const MyApp({super.key,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    getDeviceInformation();
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    String userId = SharedPreferencesUtil.getUserId();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Early Shuttle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
          dividerColor: Colors.transparent
      ),
     home: userId !=''?const Homepage(navigation: "1",): const LoginPage(),
    );
  }
}

