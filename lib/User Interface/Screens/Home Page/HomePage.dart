// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Models/HomePage_Sections/Text_Slider_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/drawer_widget.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/Evening_Tab.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/MorningTab.dart';
import 'package:early_shuttle/User%20Interface/Screens/Notification/FullScreen_Notification.dart';
import 'package:early_shuttle/User%20Interface/Screens/Notification/Notification_Screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../API/HomePage_Section/QuickBook_Api.dart';
import '../../../API/HomePage_Section/TextSlider_Banner.dart';
import '../../../API/Notification/Notification_Api.dart';
import '../../../Constant/EmergencySoSAssistiveBall.dart';
import '../../../Models/HelpSection_Model/TripRelated_Model.dart';
import '../../../Models/HomePage_Sections/QuickBook_Model.dart';
import '../../../Models/Pass_Section/PassHistory_Model.dart';
import '../../../Models/Profile_Model/ViewProfile_Model.dart';
import '../../../Models/SafetyZone/ViewContact_Model.dart';




PassHistory? ViewPassHistoryData;
GetContact? EmergencyContactData;

// TripRelated? TripTicketTypes;
UserData? ProfileData;

class Homepage extends StatefulWidget {
  final String? navigation;
  const Homepage({Key? key, this.navigation}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // ViewFullPageNotification();
    fetchHomeApis();
  }

  var NotificationCount;
  QuickBook? QuickBookView;
  BannerResponse? bannerData;

  fetchHomeApis() async {
    final NotificationData = await fetchNotifications();
    setState(() {
      NotificationCount = NotificationData!.count.toString();
    });
    final QuickBookData= await fetchQuickBookData();
    setState(() {
      QuickBookView = QuickBookData;
    });
   final Bannerdata = await  fetchBannerData();
   setState(() {
     bannerData= Bannerdata;
   });
  }

  ViewFullPageNotification() {
    if (widget.navigation == "1") {
      if (kDebugMode) {
        print("full page notification invoked");
      }
      Future.delayed(const Duration(seconds: 2), () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return FullPageNotification(
              message: "This is a full-page notification.",
            );
          },
        );
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: const drawer_widget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstant.primaryColor,
          leadingWidth: 50,
          leading: IconButton(
              onPressed: () {
                if (scaffoldKey.currentState!.isDrawerOpen) {
                  scaffoldKey.currentState!.closeDrawer();
                } else {
                  scaffoldKey.currentState!.openDrawer();
                }
              },
              icon: const Icon(
                Icons.menu,
                size: 35,
                color: Colors.white,
              )),
          title: HeadingOne(
            Title: "Early Shuttle",
            fontSize: 25,
          ),
          actions: [
            NotificationIcon(NotificationCount.toString()),
            const AssistiveBall(),
            // const SizedBox(width: 15,)
          ],
          bottom: TabBar(
            indicatorWeight: 1.3,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorConstant.greyColor,
            tabs: [
              Tab(child: TitleStyle(Title: "Morning")),
              Tab(
                  child: TitleStyle(
                Title: "Evening",
              ))
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            Morning_Tab(QuickBookView: QuickBookView, bannerData:bannerData),
            Evening_Tab(QuickBookView: QuickBookView, bannerData:bannerData),
          ],
        ),
      ),
    );
  }
 }
