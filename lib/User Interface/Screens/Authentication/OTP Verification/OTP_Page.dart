import 'dart:async';
import 'package:early_shuttle/API/Auth/VerifyOtp%20_Api.dart';
import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Screens/Authentication/Login%20Page/LoginPage.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../API/Auth/ResendOtp_Api.dart';
import '../../../../Constant/color.dart';
import '../../../Constant Widgets/Buttons/PrimaryButton.dart';
import '../../../Constant Widgets/TextStyling/AppBarTitle.dart';
import '../../../Constant Widgets/TextStyling/subtitleStyle.dart';

class opt_page extends StatefulWidget {
  final String PhoneNumber;
  final bool isRegisterd;
  final String userId;
  opt_page({
    required this.PhoneNumber,
    required this.isRegisterd, required this.userId,
  });

  @override
  State<opt_page> createState() => _opt_pageState();
}

class _opt_pageState extends State<opt_page> {
  TextEditingController otpController = TextEditingController();

  int _counter = 0;
  late Timer _timer;

  _startTimer() {
    _counter = 60; //time counter
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      body: SingleChildScrollView(
        child: CustomContainer(
          alignment: Alignment.bottomCenter,
          height: heights,
          width: widths,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeadingOne(
                alignment: Alignment.center,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                Title: "Phone Verification",
              ),
              Image.asset(
                Graphics.verifyImg,
                width: widths / 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeadingOne(
                    alignment: Alignment.center,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    Title: "OTP is sent to - ${widget.PhoneNumber} ",
                  ),
                  CustomContainer(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    width: 30,
                    child: Icon(
                      Icons.edit,
                      color: ColorConstant.whiteColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: heights / 60,
              ),
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
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(60)),
                // color: ColorConstant.whiteColor,
                height: heights / 2,
                child: Column(
                  children: [
                    SizedBox(
                      height: heights / 20,
                    ),
                    CustomContainer(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 3),
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 2,
                            spreadRadius: 1)
                      ],
                      borderRadius: BorderRadius.circular(20),
                      width: widths / 1.2,
                      height: 90,
                      color: ColorConstant.whiteColor,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 10),
                      child: Pinput(
                        controller: otpController,
                        length: 4,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                      ),
                    ),
                    SizedBox(
                      height: heights / 20,
                    ),
                    PrimaryButton(
                      onTap: () {
                        if (otpController.text.isNotEmpty) {
                          OtpVerification(
                                  context, otpController.text, widget.PhoneNumber, widget.isRegisterd, widget.userId)
                              .then((sucess) {})
                              .catchError((error) {});
                        } else {
                          Utils.flushBarErrorMessage("OTP is required", context);
                        }
                      },
                      textColor: ColorConstant.whiteColor,
                      fontSize: 20,
                      width: widths / 1.2,
                      Label: "Verify OTP",
                    ),
                    SizedBox(
                      height: heights / 15,
                    ),
                    _counter < 1
                        ? CustomContainer(
                      onTap: (){
                        print("aaaaaaaaaaaa");
                        ResendOtpApi(context, widget.PhoneNumber);
                        setState(() {
                          _startTimer();
                        });
                      },
                            gradient: LinearGradient(
                              tileMode: TileMode.mirror,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                ColorConstant.primaryColor,
                                ColorConstant.primaryColor
                              ],
                            ),
                            border: Border.all(
                                width: 0.1, color: ColorConstant.greyColor),
                            height: 40,
                            width: 120,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(2, 2),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  color: ColorConstant.darkBlackColor
                                      .withOpacity(0.5),
                                  blurStyle: BlurStyle.outer)
                            ],
                            child: SubTitle_Text(
                              textColor: ColorConstant.whiteColor,
                              Title: "Resend OTP",
                            ),
                          )
                        : PrimaryButton(

                            gradient: LinearGradient(
                              tileMode: TileMode.mirror,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                ColorConstant.gradientLightGreen,
                                ColorConstant.gradientLightblue
                              ],
                            ),
                            height: 40,
                            width: 120,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(2, 2),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  color: ColorConstant.darkBlackColor
                                      .withOpacity(0.5),
                                  blurStyle: BlurStyle.outer)
                            ],
                            child: SubTitle_Text(
                              textAlign: TextAlign.center,
                              Title:"Resend OTP  ${_counter.toString().padLeft(2, '0')}",
                            ),
                          ),
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
