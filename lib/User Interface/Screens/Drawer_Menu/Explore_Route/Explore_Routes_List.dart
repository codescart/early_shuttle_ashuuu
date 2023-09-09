import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Models/HelpSection_Model/TripRelated_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/NoData_Avl.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/Something_Wrong.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Explore_Route/RouteStops_Map.dart';
import 'package:flutter/material.dart';
import '../../../../API/Explore_Route/ExploreRoute_Api.dart';
import '../../../../Models/Explore_Route/ExploreRoute_Model.dart';
import '../../../../Utils/message_utils.dart';
import '../../../Constant Widgets/TextStyling/AppBarTitle.dart';
import '../../../Constant Widgets/TextStyling/titleStyle.dart';

class ExploreRouteList extends StatefulWidget {
  final HelpDetail? selectedTicketData;
  const ExploreRouteList({Key? key, this.selectedTicketData,}) : super(key: key);

  @override
  State<ExploreRouteList> createState() => _ExploreRouteListState();
}

class _ExploreRouteListState extends State<ExploreRouteList> {
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
          Title: "Explore Routes",
          fontSize: 25,
        ),
      ),
      body: CustomContainer(
          color: ColorConstant.whiteColor,
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<ExploreRoute>>(
            future: fetchExploreRouteData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingData();
              } else if (snapshot.hasError) {
                return const SomethingWrong();
              } else if (!snapshot.hasData) {
                return const Center(
                  child: NoDataAvailable(),
                );
              } else {
                List<ExploreRoute> routes = snapshot.data ?? [];
                return ListView.builder(
                    itemCount: routes.length,
                    itemBuilder: (context, index) {
                  ExploreRoute route = routes[index];
                  return CustomContainer(
                    onTap: (){
                      if(route.stops.length != 0){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RouteDetailsPage(
                                  route: route,
                                  selectedTicketData:widget.selectedTicketData
                              ),
                            ));
                      }
                     else{
                       return Utils.flushBarErrorMessage("No stops available for this route", context);
                      }
                    },
                    gradient: LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.topCenter,
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
                    margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                    borderRadius: BorderRadius.circular(5),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleStyle(
                              alignment: Alignment.centerLeft,
                              textColor: ColorConstant.darkBlackColor,
                              Title: "Route id: ${route.id}",
                            ),
                            TitleStyle(
                              alignment: Alignment.centerLeft,
                              textColor: ColorConstant.darkBlackColor,
                              Title: "Fare: ₹${route.fare}",
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        SubTitle_Text(
                          alignment: Alignment.centerLeft,
                          fontWeight: FontWeight.w600,
                          textColor: ColorConstant.darkBlackColor,
                          Title: "Route Name:",
                        ),
                        SubTitle_Text(
                          alignment: Alignment.centerLeft,
                          textColor: ColorConstant.darkBlackColor,
                            Title:route.routeName,
                            ),
                      ],
                    ),
                  );
                });
              }
            },
          )),
    );
  }
}