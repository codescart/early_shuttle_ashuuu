import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/NoData_Avl.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Reserve%20Seat/TimeSlot_Tab.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../Constant/SharedPreference.dart';
import '../../../Constant/url.dart';
import '../../../Models/HomePage_Sections/FindRoute_Model.dart';
import '../../Constant Widgets/ConstScreens/Something_Wrong.dart';

class Select_route extends StatefulWidget {
  final String fromLatitude;
  final String fromLongitude;
  final String toLatitude;
  final String toLongitude;
  final String routeType;

   Select_route({Key? key, required this.fromLatitude, required this.fromLongitude,
     required this.toLatitude, required this.toLongitude, required this.routeType,}) : super(key: key);

  @override
  State<Select_route> createState() => _Select_routeState();
}

class _Select_routeState extends State<Select_route> {

  List<dynamic> routeData = [];

  Future<List<RouteInfo>> fetchRouteData() async {
    final url = Uri.parse(AppUrls.FindRoutesApiUrl);
    final String token = SharedPreferencesUtil.getUserAccessToken();
    final String userId= SharedPreferencesUtil.getUserId();
    print(widget.fromLongitude);
    print(widget.fromLatitude);
    print(widget.toLongitude);
    print(widget.toLatitude);

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json",
    };
    final data = {
      "deslatitude": widget.toLatitude,
      "deslongitude": widget.toLongitude,
      "srclatitude": widget.fromLatitude,
      "Srclongitude": widget.fromLongitude,
      "user_id": userId,
      "route_type":widget.routeType
    };

    final response = await http.post(
        url,
        headers: headers,
        body: json.encode(data)
    );;

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'];
      print(jsonData);
      return jsonData.map<RouteInfo>((data) => RouteInfo.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load route data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.primaryColor,
        titleSpacing: 0,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 18,color: ColorConstant.whiteColor,),),
        centerTitle: true,
        title:HeadingOne(
          Title: "Select The Route",
        ) ,
      ),
      body: Container(
        height: heights,
        decoration: const BoxDecoration(
        ),
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        child:FutureBuilder<List<RouteInfo>>(
          future: fetchRouteData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingData();
            } else if (snapshot.hasError) {
              return const NoDataAvailable();
            } else if (!snapshot.hasData) {
              return const NoDataAvailable();
            } else {
              final routeDataResponse = snapshot.data!;
              return ListView.builder(
                  itemCount: routeDataResponse.length,
                  itemBuilder: (context, index){
                    final routeList = routeDataResponse[index];
                    return routeDataResponse.isNotEmpty? CustomContainer(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TimeSlotTab(
                          navigateStatus: '1',
                          srcStop:routeList.pickupStopName,
                          desStop:routeList.dropStopName,
                          routeName:routeList.routeName,
                          routeId:routeList.routeId.toString(),
                          stopId:routeList.pickupStop.toString(),
                          pickupId:routeList.pickupStop.toString(),
                          dropId:routeList.dropStop.toString(),
                        )));
                      },
                      border: Border.all(
                          width: 0.8, color: ColorConstant.greyColor.withOpacity(0.2)
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: AlignmentDirectional.topCenter,
                        colors: [
                          ColorConstant.gradientLightGreen,
                          ColorConstant.gradientLightblue
                        ],
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      // height: heights/5,
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                      spreadRadius: 0,
                      shadowColor:ColorConstant.greyColor.withOpacity(0.2),
                      blurRadius: 2,
                      blurStyle: BlurStyle.inner,
                      child: Column(
                        children: [
                          CustomContainer(
                            padding: const EdgeInsets.only(left: 3, top: 3, bottom: 3),
                            alignment: Alignment.center,
                            // height: 25,
                            width:widths/1.2,
                            color: ColorConstant.whiteColor.withOpacity(0.7),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                            ),
                            child: Small_Text(
                              width: widths/1.3,
                                fontSize: 11,
                                // overflow: TextOverflow.ellipsis,
                                Title:"Route No-"+"${routeList.routeId }, " +"${routeList.routeName}"
                              // "Route No- 30 Dwarka Mor -Sector 62 Golf Course Road",
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(Graphics.orangeRound, scale: 18,),
                                    const SizedBox(height: 10,),
                                    // Image.asset(Graphics.routes, scale: 8,),
                                    Image.asset(Graphics.mapIcon, scale: 8,),
                                    const SizedBox(height: 10,),
                                    Image.asset(Graphics.bluePin, scale: 18,),
                                  ]
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Small_Text(
                                        alignment: Alignment.centerLeft,
                                          width: widths/1.8,
                                          Title: routeList.pickupStopName
                                      ),
                                      CustomContainer(
                                        width: widths/5 ,
                                        child: Column(
                                          children: [
                                            Small_Text(
                                              // width: wid,
                                              Title: "Distance",
                                            ),
                                            Small_Text(
                                                textColor: ColorConstant.blueColor,
                                                Title: routeList.distance2.toStringAsFixed(2)
                                              // "25 Km",
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8,bottom: 8),
                                    height: 1,
                                    width: widths/1.3,
                                    color: ColorConstant.greyColor.withOpacity(0.4),
                                  ),
                                  Row(
                                    children: [
                                      Small_Text(
                                        alignment: Alignment.centerLeft,
                                          width: widths/1.8,
                                          Title: routeList.dropStopName
                                        // "Sector-4/5 Crossing Bus Stand, Dwarka",
                                      ),
                                      CustomContainer(
                                        padding: const EdgeInsets.all(0),
                                        width: widths/5,
                                        child: Column(
                                          children: [
                                            Small_Text(
                                              Title: "Distance",
                                            ),
                                            Small_Text(
                                                textColor: ColorConstant.blueColor,
                                                Title: routeList.distance.toStringAsFixed(2)
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ):TitleStyle(
                      textColor: Colors.black,
                      Title: "No Data available for selected route",
                    );
                  });
            }
          },
        )
      ),
    );
  }
}

// Api for find Route........
// Future<RouteData> fetchRoutes() async {
//   final url = Uri.parse(AppUrls.FindRoutesApiUrl);
//   final headers = {
//     "Content-Type": "application/json",
//     // Add authorization headers if required
//   };
//   final data = {
//     "deslatitude": "28.57297",
//     "deslongitude": "77.06622",
//     "srclatitude": "28.49526",
//     "Srclongitude": "77.0924",
//     "user_id": "5358"
//   };
//
//   final response = await http.post(
//       url,
//       headers: headers,
//       body: json.encode(data)
//   );
//
//   if (response.statusCode == 200) {
//     final responseData = json.decode(response.body);
//     return RouteData.fromJson(responseData);
//   } else {
//     throw Exception("Failed to fetch notifications");
//   }
// }
