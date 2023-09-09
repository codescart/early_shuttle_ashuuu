import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Models/HomePage_Sections/QuickBook_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Reserve%20Seat/Today_Select_Time_Slot.dart';
import 'package:early_shuttle/User%20Interface/Screens/Reserve%20Seat/Tomorrow_Select_Time_Slot.dart';
import 'package:flutter/material.dart';

class TimeSlotTab extends StatefulWidget {
  final String navigateStatus;
  final QuickBookData? LastRideData;
  final String? srcStop;
  final String? desStop;
  final String? routeName;
  final String? routeId;
  final String? stopId;
  final String? pickupId;
  final String? dropId;
  final String? orderId;
  final String? busScheduleId;
  final String? description;

  const TimeSlotTab({
    Key? key,
    required this.navigateStatus,
    this.LastRideData,  this.srcStop,  this.desStop,  this.routeName,
    this.routeId,  this.stopId, this.pickupId, this.dropId,  this.orderId,  this.busScheduleId, this.description,
  }) : super(key: key);

  @override
  State<TimeSlotTab> createState() => _TimeSlotTabState();
}

class _TimeSlotTabState extends State<TimeSlotTab> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstant.primaryColor,
          leadingWidth: 50,
          title: HeadingOne(
            Title: "Select Time Slot",
            fontSize: 25,
          ),
          bottom: TabBar(
            indicatorWeight: 1.3,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorConstant.greyColor,
            tabs: [
              Tab(child: TitleStyle(Title: "Today")),
              Tab(
                  child: TitleStyle(
                Title: "Tomorrow",
              ))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TodaySelectTimeSlot(navigateStatus: widget.navigateStatus, srcStop: widget.srcStop,
              desStop: widget.desStop, routeName: widget.routeName, routeId:widget.routeId,
              stopId: widget.stopId, pickupId: widget.pickupId, dropId: widget.dropId, orderid:widget.orderId, busScheduleId:widget.busScheduleId, description:widget.description),
            TomorrowSelectTimeSlot(navigateStatus: widget.navigateStatus, srcStop: widget.srcStop,
              desStop: widget.desStop, routeName: widget.routeName, routeId:widget.routeId,
              stopId: widget.stopId, pickupId: widget.pickupId, dropId: widget.dropId, orderid:widget.orderId, busScheduleId:widget.busScheduleId,description:widget.description),
          ],
        ),
      ),
    );
  }
}
