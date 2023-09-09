// ignore_for_file: non_constant_identifier_names

import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Rides%20Section/Cancel_Reason_BottomSheet.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Rides%20Section/Reschedule_Popup.dart';
import 'package:flutter/material.dart';
import '../../../API/Rides_Section/CurrentRides_Api.dart';
import '../../../Constant/assets.dart';
import '../../../Constant/color.dart';
import '../../../Models/My_RidesSection/CurrentRides_Model.dart';
import '../../../main.dart';
import '../../Constant Widgets/Other_Features/OpenDialer.dart';
import '../../Constant Widgets/TextStyling/smallTextStyle.dart';
import '../../Constant Widgets/TextStyling/subtitleStyle.dart';
import '../../OtherPages/Qr_Scanner.dart';

class CurrentRideScreen extends StatefulWidget {
  const CurrentRideScreen({Key? key,}) : super(key: key);

  @override
  State<CurrentRideScreen> createState() => _CurrentRideScreenState();
}

class _CurrentRideScreenState extends State<CurrentRideScreen> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  CurrentRidesModel? OngoingRide;
  fetchData() async{
    final Data= await fetchCurrentRidesData();
    setState(() {
      OngoingRide= Data!;
    });

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentRidesModel?>(
      future: fetchCurrentRidesData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasError) {
          return const SizedBox();
        } else if (snapshot.data!.status==0) {
          return SizedBox();
        } else {
          final currentRidesModel = snapshot.data!.data;
          return ListView.builder(
            // padding: EdgeInsets.all(0),
            shrinkWrap: true,
              itemCount:1,
              itemBuilder:(context, index){
                final Data = currentRidesModel.first;
                return CustomContainer(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorConstant.whiteColor,
                  margin: EdgeInsets.only(bottom: 10),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.only(left: 10, right: 10),
                    childrenPadding: const EdgeInsets.only(left: 10, right: 10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubTitle_Text(
                          width: width/3,
                          textColor: ColorConstant.blueColor,
                          alignment: Alignment.centerLeft,
                          Title: "Current Ride",
                        ),
                        SubTitle_Text(
                          alignment: Alignment.centerRight,
                          fontSize: width/30,
                          width: width/3,
                          fontWeight: FontWeight.w900,
                          Title: "OTP: ${currentRidesModel.first.otp}",
                        ),
                      ],
                    ),
                    subtitle:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Small_Text(
                          alignment: Alignment.centerLeft,
                          Title: "${Data.pickupDate.substring(0,10)} at ${Data.pickupTime}",
                          // Title: "OTP:2048",
                        ),
                        SubTitle_Text(
                          alignment: Alignment.centerRight,
                          fontSize:  width/30,
                          width: width/2.6,
                          Title: "OrderId: ${Data.id}",
                        ),
                      ],
                    ),
                    children: [
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomContainer(
                            width: width/1.5,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(Graphics.orangeRound, scale: height/60,),
                                    const SizedBox(width: 15,),
                                    SubTitle_Text(
                                      alignment: Alignment.centerLeft,
                                      width: width/1.8,
                                      Title: currentRidesModel.first.pickupName,
                                      textColor: Colors.black,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(Graphics.bluePin, scale: height/50,),
                                    const SizedBox(width: 15,),
                                    SubTitle_Text(
                                      alignment: Alignment.centerLeft,
                                      width: width/1.8,
                                      Title: currentRidesModel.first.dropName,
                                      textColor: Colors.black,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10,),
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const QRViewExample()));
                              },
                              child: Image.asset(Graphics.qrscan, scale: width/60)),
                        ],
                      ),
                      CustomContainer(
                        width: width/1.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(Graphics.busFace, scale: width/40,),
                                const SizedBox(width: 5,),
                                Small_Text(
                                  Title: "Bus No:\n${currentRidesModel.first.busNumber}",
                                )
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: (){
                                OpenDailerPad.openDialPad(currentRidesModel.first.driverNumber);
                              },
                              child: Row(
                                children: [
                                   Icon(Icons.call, color: ColorConstant.blueColor,),
                                  const SizedBox(width: 5,),
                                  Small_Text(
                                    Title: "Driver Phone:\n${currentRidesModel.first.driverNumber}",
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrimaryButton(
                            onTap: (){
                              showDialog(context: context, builder: (BuildContext context)=>ReschedulePopup(rescheduleRideData:Data));
                            },
                            width: width/2.5,
                            Label: "Reschedule",
                          ),
                          PrimaryButton(
                            onTap: (){
                              showDialog(context: context, builder: (BuildContext context)=>CancelReason(selectedData:Data, ));
                            },
                            color: Colors.red,
                            width: width/2.5,
                            Label: "Cancel",
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                );
              });
        }
      },
    );

    //   OngoingRide!=null || OngoingRide!.status ==1?
    // CustomContainer(
    //   borderRadius: BorderRadius.circular(8),
    //   color: ColorConstant.whiteColor,
    //   child: ExpansionTile(
    //     tilePadding: const EdgeInsets.only(left: 10, right: 10),
    //     childrenPadding: const EdgeInsets.only(left: 10, right: 10),
    //     title: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         SubTitle_Text(
    //           width: width/3,
    //           textColor: ColorConstant.blueColor,
    //           alignment: Alignment.centerLeft,
    //           Title: "Current Ride",
    //         ),
    //         SubTitle_Text(
    //           alignment: Alignment.centerRight,
    //           fontSize:  width/30,
    //           width: width/2.6,
    //           Title: "OrderId: ${OngoingRide!.data.first.id}",
    //         ),
    //       ],
    //     ),
    //     subtitle:Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Small_Text(
    //           alignment: Alignment.centerLeft,
    //           Title: "${OngoingRide!.data.first.pickupDate.substring(0,10)} at ${OngoingRide!.data.first.pickupTime}",
    //           // Title: "OTP:2048",
    //         ),
    //         SubTitle_Text(
    //           alignment: Alignment.centerRight,
    //           fontSize: width/30,
    //           width: width/3,
    //           Title: "OTP: ${OngoingRide!.data.first.otp}",
    //         ),
    //       ],
    //     ),
    //     children: [
    //       const Divider(),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           CustomContainer(
    //             width: width/1.5,
    //             child: Column(
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Image.asset(Graphics.orangeRound, scale: height/60,),
    //                     const SizedBox(width: 15,),
    //                     SubTitle_Text(
    //                       alignment: Alignment.centerLeft,
    //                       width: width/1.8,
    //                       Title: OngoingRide!.data.first.pickupName,
    //                       textColor: Colors.black,
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 20,),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Image.asset(Graphics.bluePin, scale: height/50,),
    //                     const SizedBox(width: 15,),
    //                     SubTitle_Text(
    //                       alignment: Alignment.centerLeft,
    //                       width: width/1.8,
    //                       Title: OngoingRide!.data.first.dropName,
    //                       textColor: Colors.black,
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 10,),
    //                 CustomContainer(
    //                   width: width/1.2,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Image.asset(Graphics.busFace, scale: width/40,),
    //                           const SizedBox(width: 5,),
    //                           Small_Text(
    //                             Title: "Bus No:\n${OngoingRide!.data.first.busNumber}",
    //                           )
    //                         ],
    //                       ),
    //                       const Spacer(),
    //                       GestureDetector(
    //                         onTap: (){
    //                           OpenDailerPad.openDialPad(OngoingRide!.data.first.driverNumber);
    //                         },
    //                         child: Row(
    //                           children: [
    //                             const Icon(Icons.person, color: Colors.orange,),
    //                             const SizedBox(width: 5,),
    //                             Small_Text(
    //                               Title: "Driver Phone:\n${OngoingRide!.data.first.driverNumber}",
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //
    //                     ],
    //                   ),
    //                 ),
    //                 const SizedBox(height: 10,),
    //               ],
    //             ),
    //           ),
    //           GestureDetector(
    //               onTap: (){
    //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const QRViewExample()));
    //               },
    //               child: Image.asset(Graphics.qrscan, scale: width/60)),
    //         ],
    //       ),
    //       const SizedBox(height: 10,),
    //     ],
    //   ),
    // ):const SizedBox();
  }
}
