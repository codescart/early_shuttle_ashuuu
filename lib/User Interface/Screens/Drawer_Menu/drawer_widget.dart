// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:early_shuttle/Constant/SharedPreference.dart';
import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Constant/global_call.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Screens/Authentication/Login%20Page/LoginPage.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Coupon/CouponsScreen.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Help.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/My%20Credit%20Section/MyCredit_Screen.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/My%20Pass/MyPass_Screen.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Profile/ViewProfile.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Refer&Earn/Refer_Earn_Screen.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Rides%20Section/MyRides.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Safety/Safety%20Zone.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../API/Profile_Section/ViewProfile_Api.dart';
import '../../Constant Widgets/Dialog/AlertDialog.dart';
import '../../Constant Widgets/TextStyling/titleStyle.dart';
import 'Explore_Route/Explore_Routes_List.dart';

var userName;
class drawer_widget extends StatefulWidget {
  const drawer_widget({Key? key}) : super(key: key);

  @override
  State<drawer_widget> createState() => _drawer_widgetState();
}

class _drawer_widgetState extends State<drawer_widget> {
  // UserData? ProfileData;
  @override
  void initState() {
    GotData();
    super.initState();
  }

  GotData() {
    fetchProfileViewData().then((value) {
      setState(() {
        GlobalCallClass.ProfileData = value.data;
        userName= GlobalCallClass.ProfileData!.name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GlobalCallClass.ProfileData == null
          ? const LoadingData()
          : ListView(
              padding: const EdgeInsets.all(0),
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                viewProfile(ProfileData: GlobalCallClass.ProfileData)));
                  },
                  child: DrawerHeader(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor,
                    ),
                    child: UserAccountsDrawerHeader(
                      margin: const EdgeInsets.all(0),
                      decoration:
                          BoxDecoration(color: ColorConstant.primaryColor),
                      accountName: Text(GlobalCallClass.ProfileData!.name.toString(),
                          style: GoogleFonts.alike(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                                color: ColorConstant.darkBlackColor),
                          )),
                      accountEmail: Text(GlobalCallClass.ProfileData!.phone.toString(),
                          style: GoogleFonts.alike(
                            textStyle: TextStyle(
                                //15
                                height: 1,
                                fontSize:
                                    MediaQuery.of(context).size.width / 22,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                                color: ColorConstant.darkBlackColor),
                          )),
                      currentAccountPictureSize: const Size.square(75),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: ColorConstant.whiteColor,
                        backgroundImage: const AssetImage(Graphics.dummyProfile),
                      ), //circleAvatar
                    ), //UserAccountDrawerHeader
                  ),
                ), //DrawerHeader
                ListTile(
                  leading: const Icon(Icons.content_paste_sharp),
                  title: TitleStyle(
                    textColor: Colors.black,
                    alignment: Alignment.centerLeft,
                    Title: "My Pass",
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyPassScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.directions_bus_outlined),
                  title: TitleStyle(
                    textColor: Colors.black,
                    alignment: Alignment.centerLeft,
                    Title: "My Rides",
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyRidesScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_balance_wallet_outlined),
                  title: TitleStyle(
                    textColor: Colors.black,
                    alignment: Alignment.centerLeft,
                    Title: "My Credit",
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyCredit()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share_outlined),
                  title: TitleStyle(
                    textColor: Colors.black,
                    alignment: Alignment.centerLeft,
                    Title: "Refer & Earn",
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ReferEarn()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.local_offer_outlined),
                  title: TitleStyle(
                    textColor: Colors.black,
                    alignment: Alignment.centerLeft,
                    Title: "Coupons",
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CouponsScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.health_and_safety_outlined),
                  title: TitleStyle(
                    textColor: Colors.black,
                    alignment: Alignment.centerLeft,
                    Title: "Safety Zone",
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SafetyZone()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.route),
                  title: TitleStyle(
                    textColor: Colors.black,
                    alignment: Alignment.centerLeft,
                    Title: "Explore Routes",
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExploreRouteList()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline_outlined),
                  title: TitleStyle(
                    textColor: Colors.black,
                    alignment: Alignment.centerLeft,
                    Title: "Help",
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Help()));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  onTap: () {
                    SharedPreferencesUtil.clearUserId();
                    SharedPreferencesUtil.clearUserAccessToken();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  color: ColorConstant.darkBlue,
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  Label: "Logout",
                )
              ],
            ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConstantDialog(
          title: 'Attention',
          message: 'Are you want to logout?',
          positiveButtonText: 'yes',
          onPositivePressed: () {
            setState(() {
              // SharedPreferencesUtil.clearUserId();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            });
          },
          negativeButtonText: "no",
          onNegativePressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
