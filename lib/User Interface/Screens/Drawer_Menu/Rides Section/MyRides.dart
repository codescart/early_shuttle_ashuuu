import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Rides%20Section/CurrentRides_Screen.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Rides%20Section/RidesHistory_Screen.dart';
import 'package:flutter/material.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({Key? key}) : super(key: key);

  @override
  State<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.primaryColor,
          leadingWidth: 50,
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios, size: 20,color: ColorConstant.whiteColor,),),
          title:  HeadingOne(
            Title: "My Rides",
            fontSize: 25,
          ),
          bottom: TabBar(
            indicatorWeight: 1.3,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorConstant.greyColor,
            tabs: [
              Tab(
                  child: TitleStyle(
                      Title:"Current Rides"
                  )
              ),
              Tab(
                  child:TitleStyle(
                    Title: "History",
                  )
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CurrentRides(),
            RidesHistory(status: "0",),
          ],
        ),
      ),
    );
  }
}
