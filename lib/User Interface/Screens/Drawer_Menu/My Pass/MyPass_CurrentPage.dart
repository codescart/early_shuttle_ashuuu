import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Models/Pass_Section/Current_Pass_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/NoData_Avl.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/My%20Pass/Selected_Pass_Information.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Terms%20&%20Condition/T&C_PopUp.dart';
import 'package:early_shuttle/User%20Interface/Screens/Reserve%20Seat/TimeSlot_Tab.dart';
import 'package:flutter/material.dart';

import '../../../../API/Pass_Section/CurrentPass_Api.dart';
import '../../../../Constant/color.dart';
import '../../../Constant Widgets/Buttons/Text_Button.dart';

class CurrentPass extends StatefulWidget {
  const CurrentPass({Key? key}) : super(key: key);

  @override
  State<CurrentPass> createState() => _CurrentPassState();
}

class _CurrentPassState extends State<CurrentPass> {

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return FutureBuilder<CurrentPassListModel>(
      future: fetchCurrentPassData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for data, show a loading indicator
          return const LoadingData();
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return NoDataAvailable();
        } else if (!snapshot.hasData) {
          // If there's no data, display a message
          return NoDataAvailable();
        } else {
          return snapshot.data!.data.passes.isNotEmpty?
          ListView.builder(
              itemCount: snapshot.data!.data.passes.length,
              itemBuilder:(context, index){
               final currentPassData = snapshot.data!.data.passes[index];
                return CustomContainer(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: AlignmentDirectional.topCenter,
                    colors: [
                      ColorConstant.gradientLightblue,
                      ColorConstant.gradientLightGreen,
                    ],
                  ),
                  margin: EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(5),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubTitle_Text(
                            Title: "₹ ${currentPassData.passPrice}",
                          ),
                          SubTitle_Text(
                            Title: "Monthly Pass",
                          ),
                          CustomContainer(
                              width: widths/12,
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedPassInformation(purchase: null,)));
                              },
                              image: DecorationImage(
                                image: AssetImage(Graphics.replaceCupon),
                                fit: BoxFit.contain
                              ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Graphics.appIcon, width: widths/7,),
                          SizedBox(width: 10,),
                          SubTitle_Text(
                            width: widths/1.5,
                            Title: "Route No- ${currentPassData.urouteId}, ${currentPassData.routeName}",
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Small_Text(
                                Title: "Total Rides",
                              ),
                              Small_Text(
                                Title: currentPassData.rides.toString(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Small_Text(
                                Title: "Used",
                              ),
                              Small_Text(
                                Title:currentPassData.avail.toString(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Small_Text(
                                Title: "Remaining",
                              ),
                              Small_Text(
                                Title: currentPassData.remaining.toString(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Small_Text(
                                Title: "Expiry On",
                              ),
                              Small_Text(
                                Title: currentPassData.expireOn.substring(0,10),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      PrimaryButton(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSlotTab(
                          //   navigateStatus: '2',
                          //   srcStop:"currentPassData.pickupStopName",
                          //   desStop:"routeList.dropStopName",
                          //   routeName:"routeList.routeName",
                          //   routeId:currentPassData.,
                          //   stopId:routeList.pickupStop.toString(),
                          //   pickupId:routeList.pickupStop.toString(),
                          //   dropId:routeList.dropStop.toString(),
                          // )));
                        },
                        textColor: ColorConstant.whiteColor,
                        fontSize: 18,
                        width: widths/1.2,
                        Label: "Book Seat",
                      ),
                      SizedBox(height: 10,),
                      Text_Button(
                        onTap: (){
                          showDialog(context: context, builder: (BuildContext context)=>TandCPupUp());
                        },
                        textColor:ColorConstant.blueColor,
                        Title: "Terms & Condition",
                      )
                    ],
                  ),
                );
              }): NoDataAvailable(title: "No current pass available",);
        }
      },
    );
  }
}
