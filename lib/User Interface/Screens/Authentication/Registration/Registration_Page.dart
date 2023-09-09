import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Text%20Field/TextField_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../API/Auth/User_Registration.dart';

class RegistrationPage extends StatefulWidget {
  final String phoneNumber;
  final String userId;
  const RegistrationPage({Key? key, required this.phoneNumber, required this.userId}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController referalController = TextEditingController();
  bool checkBox = false;
  String email = '';
  var UserData;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    getDeviceInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      body:SingleChildScrollView(
        child: CustomContainer(
          alignment: Alignment.bottomCenter,
          height: heights, width: widths,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              HeadingOne(
                padding: const EdgeInsets.only(left: 25),
                fontSize: 30,
                fontWeight: FontWeight.w600,
                Title: "Superb!!!",
              ),
              const SizedBox(height: 25,),
              HeadingOne(
                padding: const EdgeInsets.only(left: 25),
                fontWeight: FontWeight.w600,
                Title: "Let's Get Shuttling",
              ),
              SizedBox(height: heights/20,),
              CustomContainer(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorConstant.gradientLightGreen,
                      ColorConstant.gradientLightblue
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60)
                  ),
                  height: heights/1.8,
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(height: heights/20,),
                        CustomTextField(
                          fieldRadius: BorderRadius.circular(10),
                          label: "Name",
                          hintSize: 20,
                          controller: nameController,
                          fontSize: 22,
                          fillColor: ColorConstant.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: ColorConstant.greyColor.withOpacity(0.8)),
                          width: widths/1.1,
                        ),
                        SizedBox(height: heights/40,),
                        CustomTextField(
                          errorText: isEmailValid ? null : 'Invalid email format',
                          fieldRadius: BorderRadius.circular(10),
                          label: "Email Address",
                          hintSize: 20,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          fontSize: 22,
                          fillColor: ColorConstant.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: ColorConstant.greyColor.withOpacity(0.8)),
                          width: widths/1.1,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                .hasMatch(value)) {
                              return 'Invalid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: heights/40,),
                        CustomTextField(
                          fieldRadius: BorderRadius.circular(10),
                          label: "Referal code (if any)",
                          hintSize: 20,
                          controller: referalController,
                          fontSize: 22,
                          fillColor: ColorConstant.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: ColorConstant.greyColor.withOpacity(0.8)),
                          width: widths/1.1,
                        ),
                        SizedBox(height: heights/25,),
                        PrimaryButton(
                          onTap: (){
                            if(nameController.text.isEmpty  && emailController.text.isEmpty){
                              Utils.flushBarErrorMessage("Enter a valid details ", context);
                            }
                            else if(nameController.text.isEmpty){
                              Utils.flushBarErrorMessage("Enter a valid Name", context);
                            }
                            else if(emailController.text.isEmpty){
                              Utils.flushBarErrorMessage("Enter a valid Email", context);
                            }
                            else{
                                UserRegistration(context,widget.phoneNumber,nameController.text, emailController.text,
                                    referalController.text, widget.userId,deviceId, deviceName,deviceModel) ;
                            }//
                          },
                          color: ColorConstant.primaryColor,
                          textColor:ColorConstant.whiteColor,
                          fontSize: 20,
                          width: widths/1.1,
                          Label: "Register",
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
  String deviceId = '';
  String deviceName = '';
  String deviceModel = '';
  String deviceOS = '';
  void getDeviceInformation() async {
    print("function on");
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          deviceId = androidInfo.id;
          deviceName = androidInfo.device;
          deviceModel = androidInfo.model;
          deviceOS = 'Android ${androidInfo.version.release}';
        });

      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        setState(() {
          deviceId = iosInfo.identifierForVendor.toString();
          deviceName = iosInfo.name;
          deviceModel = iosInfo.model;
          deviceOS = 'iOS ${iosInfo.systemVersion}';
        });
      }
    } catch (e) {
      print('Error getting device info: $e');
    }
  }

  // Email validation
  bool isEmailValid = true;
  void validateEmail() {
    setState(() {
      // Use a simple regular expression for basic email format validation
      isEmailValid = isValidEmail(emailController.text);
    });

    if (isEmailValid) {
      // Valid email, you can proceed with further actions
      print('Email is valid: ${emailController.text}');
    } else {
      // Invalid email, handle accordingly
      print('Invalid email format: ${emailController.text}');
    }
  }

  bool isValidEmail(String email) {
    // Simple email format validation using a regular expression
    RegExp emailRegex =
    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
}

