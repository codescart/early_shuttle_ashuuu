// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Booking_Related_PopUp.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/TicketSubmitedPopUp.dart';
import 'package:flutter/material.dart';

import '../../../../API/Help_Section/SubmitTicket_Api.dart';
import '../../../../API/Help_Section/TripRelatedTickets_Api.dart';
import '../../../../Constant/global_call.dart';

class PaymentRelated extends StatefulWidget {
  const PaymentRelated({Key? key}) : super(key: key);

  @override
  State<PaymentRelated> createState() => _PaymentRelatedState();
}

class _PaymentRelatedState extends State<PaymentRelated> {
  var selectedOption;
  var isSeleted;
  // var isSelectedType;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  var isSelectedType;

  _fetchData() async {
    try {
      final data = await fetchTripRelatedTicketTypes();
      setState(() {
        GlobalCallClass.TripTicketTypes = data;
      });
    } catch (error) {}
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
          Title: GlobalCallClass.TripTicketTypes!.data[3].type,
          fontSize: 25,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            // const SizedBox(height: 20,),
            // const Divider(),
            // ListTile(
            //   onTap: (){
            //     SubmitHelpTicket(
            //         context,
            //         "",
            //         "",
            //         "Unable to book ride");
            //   },
            //   leading: const Icon(
            //     Icons.thumb_up_alt_outlined,
            //   ),
            //   trailing: const SizedBox(),
            //   title: SubTitle_Text(
            //     alignment: Alignment.centerLeft,
            //     Title: "Unable to book ride.",
            //   ),
            // ),
            // const Divider(),
            // ListTile(
            //   onTap: (){
            //     SubmitHelpTicket(
            //         context,
            //         "",
            //         "",
            //         "Ride Cancelled").then((value) => showDialog(context: context, builder: (BuildContext context)=>const TicketSubmittedPupUp()));
            //   },
            //   trailing: const SizedBox(),
            //   leading:const Icon(
            //     Icons.thumb_up_alt_outlined,
            //   ),
            //   title: SubTitle_Text(
            //     alignment: Alignment.centerLeft,
            //     Title: "Ride cancelled",
            //   ),
            // ),
            Column(
              children: List.generate(
                  GlobalCallClass.TripTicketTypes!.data[3].details.length,
                      (index) {
                    final TicketType =
                    GlobalCallClass.TripTicketTypes!.data[3].details[index];
                    return Card(
                      color: ColorConstant.gradientLightGreen,
                      child: ListTile(
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        onTap: () {
                          setState(() {
                            isSelectedType = TicketType.tktTypeDetailDescription;
                          });
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  BookingRelatedPopUp(
                                      TicketType: TicketType,
                                      // ordId:widget.Needhelpfor!.id.toString(),
                                      description:
                                      TicketType.tktTypeDetailDescription));
                        },
                        leading: isSelectedType == TicketType.tktTypeDetailId
                            ? Icon(
                          Icons.thumb_up,
                          color: ColorConstant.blueColor,
                        )
                            : const Icon(
                          Icons.thumb_up_alt_outlined,
                        ),
                        title: SubTitle_Text(
                          alignment: Alignment.centerLeft,
                          Title: TicketType.tktTypeDetailDescription,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// to show text box for the selection of different boxes accorind to need
// driver beaviour = 1
// vehicle not clean = 2
// Ac not work = 3
