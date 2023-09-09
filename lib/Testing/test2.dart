import 'package:early_shuttle/Models/Explore_Route/ExploreRoute_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/My%20Pass/Selected_Pass_Information.dart';
import 'package:flutter/material.dart';

import '../../../../API/Pass_Section/Purchase_Pass_Api.dart';
import '../../../../Constant/color.dart';
import '../../../../Models/Pass_Section/Purchase_Pass_Model.dart';
import '../../../../Testing/test3.dart';
import '../../../../Testing/test4.dart';
import '../User Interface/Constant Widgets/ConstScreens/NoData_Avl.dart';
import '../User Interface/Constant Widgets/TextStyling/RichText.dart';

class testingPassFilter extends StatefulWidget {
  final List<Stop>? uroute;
  const testingPassFilter({
    Key? key,
    required,
    this.uroute,
  }) : super(key: key);

  @override
  State<testingPassFilter> createState() => _testingPassFilterState();
}

class _testingPassFilterState extends State<testingPassFilter> {
  @override
  void initState() {
    super.initState();
    fetchPurchaseData();
  }

  @override
  Widget build(BuildContext context) {
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
          alignment: Alignment.centerLeft,
          Title: "Select Pass",
          fontSize: 25,
        ),
      ),
      body: FutureBuilder<List<RouteResponse>>(
        future: fetchPurchaseData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingData();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const NoDataAvailable();
          } else {
            final routeKeyData = snapshot.data;
            print(routeKeyData);
            bool isMatch = widget.uroute!.contains(routeKeyData) &&
                widget.uroute!.contains(routeKeyData);
            // if(  )
            return ListView.builder(
                itemCount: routeKeyData!.length,
                itemBuilder: (context, index) {
                  final purchase = routeKeyData[index].routeKey;
                  bool isMatch = widget.uroute!.contains(
                          routeKeyData[index].routes[index].urouteName) &&
                      widget.uroute!.contains(
                          routeKeyData[index].routes[index].drouteName);

                  bool isBotgMatch = routeKeyData[index]
                          .routes[index].urouteName
                          .contains("Dwarka Mor - Sector 56 Golf Course Road") &&
                      routeKeyData[index]
                          .routes[index].drouteName!
                          .contains("Sector 56 Golf Course Road - Dwarka Mor");
                  if (isBotgMatch) {
                    return Text("condition satisfied");
                  } else {
                    print("condition not satisfied");
                  }
                  return CustomContainer(
                    width: Checkbox.width,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectedPassInformation(
                                  purchase: routeKeyData[index].routes)));
                    },
                    color: ColorConstant.whiteColor,
                    gradient: LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.topRight,
                      end: Alignment.bottomCenter,
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
                    margin:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    borderRadius: BorderRadius.circular(5),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomRichText(
                              textSpans: [
                                CustomTextSpan(
                                    text: 'Distance:  \n',
                                    fontWeight: FontWeight.bold),
                                CustomTextSpan(
                                  text: purchase.distance,
                                ),
                              ],
                            ),
                            CustomRichText(
                              textAlign: TextAlign.right,
                              textSpans: [
                                CustomTextSpan(
                                    text: 'Estimated Time of Arrival \n',
                                    fontWeight: FontWeight.bold),
                                CustomTextSpan(
                                  text: purchase.eta,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Small_Text(
                              alignment: Alignment.centerLeft,
                              Title: "Route 1- ",
                              fontWeight: FontWeight.bold,
                            ),
                            Small_Text(
                              alignment: Alignment.centerLeft,
                              Title: "${purchase.urouteName}",
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        Row(
                          children: [
                            Small_Text(
                              alignment: Alignment.centerLeft,
                              Title: "Route 2- ",
                              fontWeight: FontWeight.bold,
                            ),
                            Small_Text(
                              alignment: Alignment.centerLeft,
                              Title: "${purchase.drouteName}",
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

class RouteList {
  final String route1;
  final String route2;

  RouteList(this.route1, this.route2);
}
