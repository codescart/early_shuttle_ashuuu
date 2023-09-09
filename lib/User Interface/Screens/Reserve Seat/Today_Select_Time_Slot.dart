// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:early_shuttle/API/Rides_Section/Reschedule_Ride_Api.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Screens/Reserve%20Seat/Book_Ride.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../API/My_Credit/BookCancelRide_Api.dart';
import '../../../API/SeatBooking/TimeSlot_Api.dart';
import '../../../Constant/assets.dart';
import '../../../Constant/color.dart';
import '../../../Models/SeatBooking/TimeSlots_Model.dart';
import '../../Constant Widgets/ConstScreens/NoData_Avl.dart';
import '../../Constant Widgets/ConstScreens/loadingScreen.dart';
import '../../Constant Widgets/Container/Container_widget.dart';
import '../../Constant Widgets/TextStyling/smallTextStyle.dart';
import '../../Constant Widgets/TextStyling/subtitleStyle.dart';

class TodaySelectTimeSlot extends StatefulWidget {
  final String navigateStatus;
  final String? srcStop;
  final String? desStop;
  final String? routeName;
  final String? routeId;
  final String? stopId;
  final String? pickupId;
  final String? dropId;
  final String? orderid;
  final String? busScheduleId;
  final String? description;
  const TodaySelectTimeSlot(
      {super.key,
      required this.navigateStatus,
      required this.srcStop,
      required this.desStop,
      required this.routeName,
      required this.routeId,
      required this.stopId,
      required this.pickupId,
      required this.dropId,
      this.orderid,
      this.busScheduleId, this.description,
      });

  @override
  State<TodaySelectTimeSlot> createState() => _TodaySelectTimeSlotState();
}

class _TodaySelectTimeSlotState extends State<TodaySelectTimeSlot> {
  var selectedTimeSlot;
  BusDetails? selectedSchedule;
  String? currentDate;
  bool? isSlotAvl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    print(widget.routeId,);
    print(widget.stopId);
    print(currentDate);
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomContainer(
          width: widths,
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: AlignmentDirectional.topCenter,
            colors: [
              ColorConstant.gradientLightblue,
              ColorConstant.gradientLightGreen,
            ],
          ),
          margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(width: 1,color: Colors.black),
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubTitle_Text(
                      width: widths / 1.5,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      Title: widget.routeName,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      Graphics.mapIcon,
                      scale: widths / 40,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Graphics.orangeRound,
                      width: widths / 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Small_Text(
                      alignment: Alignment.centerLeft,
                      width: widths / 1.9,
                      Title: widget.srcStop,
                      textColor: Colors.black,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      Graphics.busFace,
                      width: widths / 20,
                    ),
                    Small_Text(
                      alignment: Alignment.centerRight,
                      width: widths / 6,
                      Title: "Distance \n0.08 km",
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Graphics.bluePin,
                      width: widths / 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Small_Text(
                      alignment: Alignment.centerLeft,
                      width: widths / 1.9,
                      Title: widget.desStop,
                      textColor: Colors.black,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Image.asset(
                      Graphics.busFace,
                      width: widths / 20,
                    ),
                    Small_Text(
                      alignment: Alignment.centerRight,
                      width: widths / 6,
                      Title: "Distance \n0.08 km",
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubTitle_Text(
                      fontWeight: FontWeight.bold,
                      Title:isSlotAvl==true? "Timing":"",
                    ),
                    SubTitle_Text(
                      fontWeight: FontWeight.bold,
                      Title:isSlotAvl==true? "Available":"",
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder<TimeSlot>(
                  future: fetchTimeSlotsData(widget.routeId.toString(),
                      widget.stopId.toString(), currentDate.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingData();
                    } else if (snapshot.hasError) {
                      return const NoDataAvailable();
                    } else if (snapshot.data!.status == 0) {
                      return const Center(
                        child: NoDataAvailable(),
                      );
                    }else if(snapshot.data!.data.isEmpty){
                      isSlotAvl=false;
                      return SubTitle_Text(
                        textAlign: TextAlign.center,
                        Title: "No slots are available at this route for the selected date.",
                      );
                    }
                    else {
                      final TimeSlotData = snapshot.data!.data;
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: TimeSlotData.length,
                          itemBuilder: (context, index) {
                            final slotDetail = TimeSlotData[index];
                            final pickupTime =
                                DateFormat.Hm().parse(slotDetail.pickupTime);
                            final currentTime = DateTime.now();
                            bool isPastTime = pickupTime.isBefore(currentTime);
                            return CustomContainer(
                              color: isPastTime == false? selectedTimeSlot == slotDetail.id
                                  ? Colors.white
                                  : Colors.transparent:Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                  color: isPastTime == false? selectedTimeSlot == slotDetail.id
                                      ? ColorConstant.darkBlackColor
                                          .withOpacity(0.3)
                                      : Colors.transparent:Colors.transparent,
                                  offset: const Offset(0, 4),
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                )
                              ],
                              onTap: () {
                                if(isPastTime==true){
                                  Utils.flushBarErrorMessage("Booking not allowed for past time slot", context);
                                }
                                else{
                                  setState(() {
                                    selectedTimeSlot = slotDetail.id;
                                    selectedSchedule = slotDetail;
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(5),
                              border: isPastTime == false
                                  ? selectedTimeSlot == slotDetail.id
                                      ? Border.all(
                                          width: 0.5,
                                          color: ColorConstant.whiteColor)
                                      : Border.all(
                                          width: 0,
                                          color: ColorConstant.greyColor
                                              .withOpacity(0))
                                  : Border.all(
                                      width: 0,
                                      color: Colors.transparent,
                                    ),
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SubTitle_Text(
                                    padding: const EdgeInsets.only(left: 5),
                                    width: widths / 5,
                                    fontWeight: FontWeight.bold,
                                    alignment: Alignment.centerLeft,
                                    Title: slotDetail.pickupTime,
                                    textColor: isPastTime == true
                                        ? ColorConstant.greyColor
                                        : ColorConstant.darkBlackColor,
                                  ),
                                  CustomContainer(
                                    width: widths / 5,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SubTitle_Text(
                                              textColor: isPastTime == true
                                                  ? ColorConstant.greyColor
                                                  : ColorConstant
                                                      .darkBlackColor,
                                              alignment: Alignment.centerRight,
                                              Title: slotDetail.capacity
                                                  .toString(),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            ImageIcon(
                                                const AssetImage(
                                                  Graphics.seaticon,
                                                ),
                                                color: isPastTime == true
                                                    ? ColorConstant.greyColor
                                                    : Colors.green,
                                                size: widths / 15),
                                          ],
                                        ),
                                        Small_Text(
                                          textColor: isPastTime == true
                                              ? ColorConstant.greyColor
                                              : Colors.green,
                                          Title: isPastTime == true
                                              ? "Departured"
                                              : "available",
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  },
                )
              ],
            ),
          )),
      bottomSheet: selectedTimeSlot != null
          ? PrimaryButton(
              onTap: () {
                print(selectedSchedule!.pickupTime.toString());
                if (selectedTimeSlot != null) {
                  widget.navigateStatus == "1"
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookRide(
                                  Details: selectedSchedule!,
                                  pickupId: widget.pickupId.toString(),
                                  dropId: widget.dropId.toString(),
                                  date: currentDate.toString(),
                                  src: widget.srcStop.toString(),
                                  drop: widget.desStop.toString(),
                                  route: widget.routeName.toString())))
                      :widget.navigateStatus=="3"?
                      RescheduleCurrentRide(context,
                          widget.orderid.toString(),
                          widget.busScheduleId.toString(),
                          widget.description!.toString(),
                          selectedSchedule!.pickupTime.toString(),
                          currentDate.toString()
                      )
                  :BookCancelledgRide(
                          context,
                          widget.orderid.toString(),
                          widget.busScheduleId.toString(),
                          selectedSchedule!.pickupTime.toString(),
                          currentDate.toString()
                  );
                }
                else {
                  Utils.flushBarErrorMessage(
                      "Select a valid time slot", context);
                }
              },
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 25, top: 10),
              Label: widget.navigateStatus == "2" ? "Book seat" : "Confirm",
            )
          : const SizedBox(),
    );
  }
}

class RouteList {
  final String time;
  final String total;
  final String left;
  final String status;

  RouteList(this.time, this.total, this.left, this.status);
}
