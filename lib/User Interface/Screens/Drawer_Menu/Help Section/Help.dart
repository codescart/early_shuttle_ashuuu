// ignore_for_file: non_constant_identifier_names, file_names

import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Booking_Related.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Others.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Payment_Related.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Service_Area_Timing.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/ViewSubmitedTicketList.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Want_To_Call.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Rides%20Section/RidesHistory_Screen.dart';
import 'package:early_shuttle/generated/assets.dart';
import 'package:flutter/material.dart';
import '../../../../Models/HelpSection_Model/Call-Write_Model.dart';
import '../../../Constant Widgets/Container/Container_widget.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  ContactInfoModel? Contactdata;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
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
          Title: "Help",
          fontSize: 25,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SubmitedTicketList()));
              },
              icon: Icon(Icons.history,
                  color: ColorConstant.whiteColor))
        ],
      ),
      body: CustomContainer(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            HeadingOne(
              alignment: Alignment.center,
              textColor: ColorConstant.darkBlackColor,
              Title: "We are always ready to help",
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RidesHistory(status: "1")));
                  },
                  width: widths / 2.3,
                  height: widths / 2.5,
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorConstant.gradientLightGreen,
                      ColorConstant.gradientLightblue
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: widths / 3.5,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.helpSectionTripR),
                                fit: BoxFit.contain)),
                      ),
                      CustomContainer(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        width: widths / 2.3,
                        height: 30,
                        color: Colors.white,
                        child: SubTitle_Text(
                          alignment: Alignment.center,
                          Title: "Trip Related",
                        ),
                      )
                    ],
                  ),
                ),
                CustomContainer(
                  padding: const EdgeInsets.only(top: 10),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookingRelated()));
                  },
                  width: widths / 2.3,
                  height: widths / 2.5,
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorConstant.gradientLightGreen,
                      ColorConstant.gradientLightblue
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 2.3),
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: widths/5,
                        height: widths / 4,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.helpSectionBookR),
                                fit: BoxFit.contain)),
                      ),
                      CustomContainer(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        width: widths / 2.3,
                        height: 30,
                        color: Colors.white,
                        child: SubTitle_Text(
                          Title: "Booking Related",
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ServiceAreaTiming()));
                  },
                  width: widths / 2.3,
                  height: widths / 2.3,
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorConstant.gradientLightGreen,
                      ColorConstant.gradientLightblue
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: widths/5,
                        height: widths / 3,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.helpSectionServiceR),
                                fit: BoxFit.contain)),
                      ),
                      CustomContainer(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        width: widths / 2.3,
                        height: 30,
                        color: Colors.white,
                        child: SubTitle_Text(
                          Title: "Service area",
                        ),
                      )
                    ],
                  ),
                ),
                CustomContainer(
                  padding: const EdgeInsets.only(top: 10),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentRelated()));
                  },
                  width: widths / 2.3,
                  height: widths / 2.3,
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorConstant.gradientLightGreen,
                      ColorConstant.gradientLightblue
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: widths/5,
                        height: widths / 3.5,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.helpSectionPayR),
                                fit: BoxFit.contain)),
                      ),
                      CustomContainer(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        width: widths / 2.3,
                        height: 30,
                        color: Colors.white,
                        child: SubTitle_Text(
                          textAlign: TextAlign.center,
                          Title: "Payment Related",
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomContainer(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const WantToCall()));
                  },
                  width: widths / 2.3,
                  height: widths / 2.3,
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorConstant.gradientLightGreen,
                      ColorConstant.gradientLightblue
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: widths/5,
                        height: widths / 3,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.helpSectionCallR),
                                fit: BoxFit.contain)),
                      ),
                      CustomContainer(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        width: widths / 2.3,
                        height: 30,
                        color: Colors.white,
                        child: SubTitle_Text(
                          textAlign: TextAlign.center,
                          alignment: Alignment.center,
                          Title: "Call/Write to Us",
                        ),
                      )
                    ],
                  ),
                ),
                CustomContainer(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const OtherHelp()));
                  },
                  width: widths / 2.3,
                  height: widths / 2.3,
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorConstant.gradientLightGreen,
                      ColorConstant.gradientLightblue
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: widths/5,
                        height: widths / 3,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Assets.helpSectionOtherR),
                                fit: BoxFit.contain)),
                      ),
                      CustomContainer(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        width: widths / 2.3,
                        height: 30,
                        color: Colors.white,
                        child: SubTitle_Text(
                          Title: "Others",
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
