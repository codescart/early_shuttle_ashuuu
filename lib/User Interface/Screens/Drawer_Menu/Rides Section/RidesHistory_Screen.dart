// ignore_for_file: non_constant_identifier_names

import 'package:early_shuttle/API/Rides_Section/RideHistory_Api.dart';
import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Help.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Trip_Related.dart';
import 'package:early_shuttle/User%20Interface/Screens/Reserve%20Seat/TimeSlot_Tab.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/color.dart';
import '../../../../Models/My_RidesSection/RideHistory_Model.dart';
import '../../../Constant Widgets/ConstScreens/NoData_Avl.dart';

class RidesHistory extends StatefulWidget {
  final String status;
   const RidesHistory({Key? key, required this.status}) : super(key: key);

  @override
  State<RidesHistory> createState() => _RidesHistoryState();
}

class _RidesHistoryState extends State<RidesHistory> {

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<RideHistoryResponse>(
        future: fetchRideHistoryData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingData();
          } else if (snapshot.hasError) {
            return const NoDataAvailable();
          } else if (snapshot.data!.status==0) {
            return const Center(
              child: NoDataAvailable(),
            );
          } else {
            final rideHistoryModel = snapshot.data!.data;
            return  ListView.builder(
                itemCount: rideHistoryModel.length,
                itemBuilder:(context, index){
                  final HistoryData= rideHistoryModel[index];
                  return CustomContainer(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: AlignmentDirectional.topCenter,
                      colors: [
                        ColorConstant.gradientLightblue,
                        ColorConstant.gradientLightGreen,
                      ],
                    ),
                    margin: const EdgeInsets.all(10),
                    borderRadius: BorderRadius.circular(5),
                    // border: Border.all(width: 1,color: Colors.black),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(Graphics.orangeRound, scale: heights/70,),
                                    const SizedBox(width: 15,),
                                    Small_Text(
                                      alignment: Alignment.centerLeft,
                                      width: widths/1.5,
                                      Title: HistoryData.pickupName,
                                      textColor: Colors.black,
                                    ),
                                    const SizedBox(width: 8,),
                                    Image.asset(Graphics.busFace, scale: widths/25,)
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(Graphics.bluePin, scale: heights/60,),
                                    const SizedBox(width: 15,),
                                    Small_Text(
                                      alignment: Alignment.centerLeft,
                                      width: widths/1.5,
                                      Title: HistoryData.dropName,
                                      textColor: Colors.black,
                                    ),
                                    const SizedBox(width: 8,),
                                    Image.asset(Graphics.busFace, scale: widths/25,)
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Small_Text(
                                  alignment: Alignment.centerLeft,
                                  width: widths/1.8,
                                  Title: "Date: ${HistoryData.pickupDate}",
                                ),
                                Small_Text(
                                  alignment: Alignment.centerLeft,
                                  width: widths/1.8,
                                  Title: "Time: ${HistoryData.pickupTime}",
                                ),
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.only(right: 20),
                                child: Image.asset(Graphics.qrscan, scale: widths/40,)),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(Graphics.busFace, scale: widths/40,),
                                const SizedBox(width: 5,),
                                Small_Text(
                                  Title: "Bus No:\n${HistoryData.busNumber}",
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.orange,),
                                const SizedBox(width: 5,),
                                Small_Text(
                                  maxLines: 2,
                                  width: widths/3.5,
                                  Title: "Driver Name:\n${HistoryData.dropName}",
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.payment, color: ColorConstant.blueColor,),
                                const SizedBox(width: 5,),
                                Small_Text(
                                  Title: "Paid By:Paytm",
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.menu, color: ColorConstant.blueColor,),
                                const SizedBox(width: 5,),
                                Small_Text(
                                  Title: "OrderId: ${HistoryData.id}",
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        widget.status=="1"? PrimaryButton(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> TripRelated(
                             Needhelpfor:HistoryData
                            )));
                          },
                          // width: widths/2.5,
                          fontSize: 18,
                          Label: "Need help",
                        ):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PrimaryButton(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>TimeSlotTab(
                                      navigateStatus: '1',
                                      srcStop:HistoryData.pickupName,
                                      desStop:HistoryData.dropName,
                                      routeName:HistoryData.routeName,
                                      routeId:"${HistoryData.id}",
                                      stopId:HistoryData.pickup.toString(),
                                      pickupId:HistoryData.pickup.toString(),
                                      dropId:HistoryData.drop.toString(),
                                )));
                              },
                              width: widths/2.5,
                              fontSize: 18,
                              Label: "Ride Again",
                            ),
                            PrimaryButton(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> TripRelated(
                                    Needhelpfor:HistoryData
                                )));
                              },
                              width: widths/2.5,
                              fontSize: 18,
                              Label: "Need help",
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          }
        },
      )
    );
  }
}
