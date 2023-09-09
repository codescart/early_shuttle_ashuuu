// ignore_for_file: non_constant_identifier_names, ignore: unnecessary_null_comparison, non_constant_identifier_names, duplicate_ignore, non_constant_identifier_names

import 'dart:async';

import 'package:early_shuttle/API/ReferEarn/referal_data.dart';
import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Models/ReferEarn/ReferalDetails_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/Text_Button.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/NoData_Avl.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Other_Features/Messaging.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Refer&Earn/How_it_works.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Refer&Earn/SubmitReferal_Popup.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Refer&Earn/User_Levels.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/drawer_widget.dart';
import 'package:flutter/material.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({Key? key}) : super(key: key);

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  void _startTimer() {
    const oneSec = Duration(milliseconds: 100);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_progress < 0.5) {
          _progress += 0.01; // Adjust the step size for the animation speed
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    GotData();
    delayedOperation();
  }

  ReferralData? ReferalData;
  GotData() async {
    fetchReferalData().then((value) {
      setState(() {
        ReferalData = value.data;
      });
    });
  }

  Future<void> delayedOperation() async {
    await Future.delayed(Duration(seconds: 20));
    setState(() {
      isTimeOut=true;
    });
  }

  bool? isTimeOut=false;


  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return ReferalData==null? isTimeOut==false?
        LoadingData():NoDataAvailable():
         Scaffold(
            appBar: AppBar(
              backgroundColor: ColorConstant.primaryColor,
              leadingWidth: 50,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: ColorConstant.whiteColor,
                ),
              ),
              title: HeadingOne(
                Title: "Refer & Earn",
                fontSize: 25,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CustomContainer(
                    margin: const EdgeInsets.all(15),
                    gradient: LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorConstant.gradientLightGreen,
                        ColorConstant.gradientLightblue
                      ],
                    ),
                    // padding: EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 2,
                          spreadRadius: 1)
                    ],
                    child: Column(
                      children: [
                        ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserReferalLevel()));
                            },
                            title: TitleStyle(
                              alignment: Alignment.centerLeft,
                              textColor: ColorConstant.darkBlackColor,
                              Title: userName.toString(),
                            ),
                            subtitle: SubTitle_Text(
                              alignment: Alignment.centerLeft,
                              textColor: ColorConstant.blueColor,
                              fontWeight: FontWeight.w600,
                              Title: "Level",
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: ColorConstant.darkBlackColor,
                            )),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Small_Text(
                                    alignment: Alignment.centerLeft,
                                    Title: 'Points earned',
                                  ),
                                  Small_Text(
                                    fontWeight: FontWeight.w600,
                                    Title: ReferalData!.pointEarned=="null"?"0":
                                    ReferalData!.pointEarned,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Small_Text(
                                    alignment: Alignment.centerLeft,
                                    Title: 'Points spend',
                                  ),
                                  Small_Text(
                                    fontWeight: FontWeight.w600,
                                    Title: ReferalData!.pointSpend=="null"?"0":ReferalData!.pointSpend,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Small_Text(
                                    alignment: Alignment.centerLeft,
                                    Title: 'Points remaining',
                                  ),
                                  Small_Text(
                                    fontWeight: FontWeight.w600,
                                    Title: ReferalData!.pointRemaining=="null"?"0": ReferalData!.pointRemaining,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: widths / 1.3,
                          child: LinearProgressIndicator(
                            value: _progress,
                            minHeight: 15,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                ColorConstant.primaryColor),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SubTitle_Text(
                          padding: const EdgeInsets.only(left: 10),
                          textColor: ColorConstant.blueColor,
                          Title:
                              "Referred ${ReferalData!.referredCount=="null"?"0":ReferalData!.referredCount} Person",
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  CustomContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    gradient: LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        ColorConstant.gradientLightGreen,
                        ColorConstant.gradientLightblue
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 2,
                          spreadRadius: 1)
                    ],
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        TitleStyle(
                          textAlign: TextAlign.center,
                          textColor: ColorConstant.darkBlackColor,
                          Title: ReferalData!.referralMessage=="null"?"":ReferalData!.referralMessage,
                        ),
                        Image.asset(
                          "assets/community.png",
                          width: widths / 1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        PrimaryButton(
                          onTap: () {
                            // Messaging.sendWhatsappMessage("reciverNumber");
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const SubmitReferalPopup());
                          },
                          width: widths / 1.2,
                          textColor: ColorConstant.whiteColor,
                          fontWeight: FontWeight.w600,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Graphics.whatsappIcon,
                                width: widths / 12,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SubTitle_Text(
                                fontSize: 18,
                                textColor: ColorConstant.whiteColor,
                                Title: "Refer Now",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text_Button(
                              onTap: () {
                                Messaging.sendSMS(
                                    "Hello, this is my SMS message.");
                              },
                              textColor: ColorConstant.blueColor,
                              padding: const EdgeInsets.only(left: 15),
                              Title: "Share",
                            ),
                            Text_Button(
                              padding: const EdgeInsets.only(right: 15),
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        const HowItWorks());
                              },
                              Title: "How it works",
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
