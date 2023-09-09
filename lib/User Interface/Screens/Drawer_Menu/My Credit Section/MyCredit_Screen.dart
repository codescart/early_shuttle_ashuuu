import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Reserve%20Seat/TimeSlot_Tab.dart';
import 'package:flutter/material.dart';
import '../../../../API/My_Credit/CreditRideList_Api.dart';
import '../../../../Constant/color.dart';
import '../../../../Models/My_Credit/CreditRideList_Model.dart';
import '../../../Constant Widgets/ConstScreens/NoData_Avl.dart';
import '../../../Constant Widgets/ConstScreens/loadingScreen.dart';
import '../../../Constant Widgets/TextStyling/AppBarTitle.dart';

class MyCredit extends StatefulWidget {
  const MyCredit({Key? key}) : super(key: key);

  @override
  State<MyCredit> createState() => _MyCreditState();
}

class _MyCreditState extends State<MyCredit> {

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leadingWidth: 50,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 20,color: ColorConstant.whiteColor,),),
        title:  HeadingOne(
          Title: "My Credit",
          fontSize: 25,
        ),
      ),
      body: FutureBuilder<RideList>(
        future: fetchCreditRidesData(),
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
            final creditRidesModel = snapshot.data!.data;
            return ListView.builder(
                itemCount: creditRidesModel.length,
                itemBuilder:(context, index){
                 final cancelRideData= creditRidesModel[index];
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
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                TitleStyle(
                                  alignment: Alignment.centerLeft,
                                  width: widths/1.2,
                                  Title: cancelRideData.routeName,
                                  textColor: Colors.black,
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(Graphics.orangeRound, scale: heights/70,),
                                    const SizedBox(width: 15,),
                                    Small_Text(
                                      alignment: Alignment.centerLeft,
                                      width: widths/1.4,
                                      Title: cancelRideData.pickupName,
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
                                      width: widths/1.4,
                                      Title: cancelRideData.dropName,
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
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Small_Text(
                                  alignment: Alignment.centerLeft,
                                  width: widths/1.8,
                                  Title: "Expiry On: ${cancelRideData.creditExpDt}",
                                ),
                                Small_Text(
                                  alignment: Alignment.centerLeft,
                                  width: widths/1.8,
                                  Title: "Time: 9:25 AM",
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
                                  Title: "Bus No:\n${cancelRideData.busNumber}",
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.orange,),
                                const SizedBox(width: 5,),
                                Small_Text(
                                  Title: "Driver Name:\n${cancelRideData.driverName}",
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
                                  Title: "Paid By: Paytm",
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.menu, color: ColorConstant.blueColor,),
                                const SizedBox(width: 5,),
                                Small_Text(
                                  Title: "OrderId: ${cancelRideData.id}",
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.call, color: ColorConstant.blueColor,size: 20,),
                            SubTitle_Text(
                              Title: " Driver Mobile: ${cancelRideData.driverPhone}",
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        PrimaryButton(
                          onTap:(){
                            print(cancelRideData.routeId);
                            // Utils.flushBarErrorMessage("Something went wrong", context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSlotTab(navigateStatus: '1',)));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context)=> TimeSlotTab(
                              navigateStatus: '2',
                              orderId:cancelRideData.id.toString(),
                              busScheduleId:cancelRideData.busScheduleId.toString(),
                              srcStop:cancelRideData.pickupName,
                              desStop:cancelRideData.dropName,
                              routeName:"${cancelRideData.routeName}",
                              routeId:"${cancelRideData.routeId}",
                              stopId:cancelRideData.pickup.toString(),
                              pickupId:cancelRideData.pickup.toString(), // here stop id is needed
                              dropId:cancelRideData.drop.toString(),
                            )));
                          },
                          padding: const EdgeInsets.all(0),
                          Label: "Ride Again",
                          fontSize: 18,
                          textColor: ColorConstant.whiteColor,
                        )
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
