import 'package:early_shuttle/Routes/routes/routes_name.dart';
import 'package:early_shuttle/User%20Interface/Screens/Authentication/Login%20Page/LoginPage.dart';
import 'package:early_shuttle/User%20Interface/Screens/Authentication/Registration/Registration_Page.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/HomePage.dart';
import 'package:flutter/material.dart';


class Routes{
  static Route<dynamic> generateRoutes(RouteSettings settings){
     switch(settings.name){
      case RoutesName.loginPage:
        return MaterialPageRoute(builder: (BuildContext context)=>  const LoginPage());
       // case RoutesName.verifyOTPPage:
       //   // Retrieve the phone number
       //   return MaterialPageRoute(builder: (BuildContext context)=>  opt_page(PhoneNumber:PhoneNumber));
       case RoutesName.registerPage:
         return MaterialPageRoute(builder: (BuildContext context)=>  RegistrationPage(phoneNumber: '', userId: '',));
       case RoutesName.homePage:
           return MaterialPageRoute(builder: (BuildContext context)=>  Homepage());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body:Center(
              child: Text("Page Not Found"),
            ));
        }
        );
    }
  }
}