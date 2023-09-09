
import 'package:early_shuttle/API/Auth/User_Login_Api.dart';
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Constant/url.dart';
import 'package:early_shuttle/Models/Terms_Privacy/TermsofUser_Login_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Text%20Field/TextField_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../../API/Help_Section/Call-write_Us.dart';
import '../../../../API/Terms_Privacy/Terms_Of_Use_Api.dart';
import '../../../../Constant/assets.dart';
import '../../../../Models/HelpSection_Model/Call-Write_Model.dart';
import '../../../Constant Widgets/Other_Features/OpenEmail.dart';
import '../../../Constant Widgets/Other_Features/Launchweb.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNumber = TextEditingController();
  ContactUsModel? Contactdata;
  TermsOfUse? Terms;
  @override
  void initState() {
    invokeApi();
    super.initState();
  }

  invokeApi() {
    fetchCallWriteUs().then((value) {
      setState(() {
        Contactdata = value;
      });
    });
    fetchTermsOfUseData().then((value) {
      setState(() {
        Terms = value;
      });
    });
  }

  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery
        .of(context)
        .size
        .height;
    final widths = MediaQuery
        .of(context)
        .size
        .width;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.primaryColor,
      body: SingleChildScrollView(
        child: CustomContainer(
          alignment: Alignment.bottomCenter,
          height: heights, width: widths,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              HeadingOne(
                alignment: Alignment.center,
                fontWeight: FontWeight.w600,
                Title: "Welcome to Early Shuttle Family",
              ),
              const SizedBox(height: 5,),
              SubTitle_Text(
                textColor: Colors.white,
                textAlign: TextAlign.center,
                Title: "Direct to Office, Close to Home",
              ),
              SizedBox(height: heights / 25,),
              Image.asset(Graphics.loginImg, width: widths / 1.2,),
              HeadingOne(
                alignment: Alignment.center,
                fontWeight: FontWeight.w600,
                Title: "Login",
              ),
              SizedBox(height: heights / 60,),
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
                height: heights / 2,
                child: Column(
                  children: [
                    SizedBox(height: heights / 20,),
                    CustomContainer(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 3),
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 2,
                            spreadRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.circular(15),
                      width: widths / 1.2,
                      height: 60,
                      color: ColorConstant.whiteColor,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10
                      ),
                      child: CustomTextField(
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        maxLength: 10,
                        fieldRadius: BorderRadius.circular(10),
                        filled: true,
                        height: 40,
                        label: "Phone Number",
                        hintSize: 20,
                        controller: phoneNumber,
                        keyboardType: TextInputType.number,
                        fontSize: 22,
                        fillColor: ColorConstant.greyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        // border: Border.all(width: 0.5, color: ColorConstant.greyColor.withOpacity(0.8)),
                        width: widths / 1.2,
                      ),
                    ),
                    SizedBox(height: heights / 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          activeColor: ColorConstant.primaryColor,
                            value: checkBox,
                            onChanged: (bool? value) {
                              setState(() {
                                checkBox = value!;
                              });
                            }
                        ),
                        CustomContainer(
                          onTap: (){
                            OpenChrome.openUrl(Terms!.data.url.toString());
                          },
                          width: widths/1.3,
                          child: Text.rich(
                            TextSpan(
                              text: 'I\'ve read and agreed to ',
                              style: GoogleFonts.alike(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                    color: ColorConstant.darkBlackColor
                                ),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms and Conditions.',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: ColorConstant.blueColor,
                                      decoration: TextDecoration.underline
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: heights / 40,),
                    PrimaryButton(
                      onTap: () {
                        if (checkBox == true) {
                          if (phoneNumber.text.isNotEmpty) {
                            if (phoneNumber.length == 10) {
                              UserLogin(context, phoneNumber.text);
                            }
                            else {
                              Utils.flushBarErrorMessage(
                                  "Enter a valid phone number", context);
                            }
                          }
                          else {
                            Utils.flushBarErrorMessage(
                                "Enter a valid phone number", context);
                          }
                        }
                        else {
                          Utils.flushBarErrorMessage(
                              "Agreement with the Terms and Conditions is required to proceed ",
                              context);
                        }
                      },
                      color: checkBox == false
                          ? ColorConstant.greyColor
                          : ColorConstant.primaryColor,
                      textColor: ColorConstant.whiteColor,
                      fontSize: 20,
                      width: widths / 1.2,
                      Label: "Send OTP",
                    ),
                    SizedBox(height: heights / 25,),
                    SubTitle_Text(
                      Title: "Contact Us",
                    ),
                    const SizedBox(height: 6,),
                    CustomContainer(
                      onTap: () {
                        OpenEmail.sendEmail(Contactdata!.data.email.toString());
                      },
                      gradient: LinearGradient(
                        tileMode: TileMode.mirror,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorConstant.gradientLightGreen,
                          ColorConstant.gradientLightblue
                        ],
                      ),
                      border: Border.all(
                          width: 0.1, color: ColorConstant.greyColor
                      ),
                      height: 40,
                      width: 40,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(2, 2),
                            spreadRadius: 0,
                            blurRadius: 0,
                            color: ColorConstant.darkBlackColor.withOpacity(0.5),
                            blurStyle: BlurStyle.outer
                        )
                      ],
                      child: Icon(
                        Icons.mail_outline, color: ColorConstant.blueColor,),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




