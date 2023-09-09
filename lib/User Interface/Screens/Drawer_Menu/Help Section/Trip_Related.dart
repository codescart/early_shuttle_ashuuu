// ignore_for_file: non_constant_identifier_names, empty_catches, prefer_typing_uninitialized_variables

import 'package:early_shuttle/API/Help_Section/TripRelatedTickets_Api.dart';
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/NoData_Avl.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Booking_Related_PopUp.dart';
import 'package:flutter/material.dart';
import '../../../../Constant/global_call.dart';
import '../../../../Models/My_RidesSection/RideHistory_Model.dart';

class TripRelated extends StatefulWidget {

  final RideHistoryListData? Needhelpfor;
  const TripRelated({
    Key? key, required this.Needhelpfor,
  }) : super(key: key);

  @override
  State<TripRelated> createState() => _TripRelatedState();
}

class _TripRelatedState extends State<TripRelated> {
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
    final widths = MediaQuery.of(context).size.width;
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
            Title: "Trip Related",
            fontSize: 25,
          ),
        ),
        body: GlobalCallClass.TripTicketTypes == null
            ? const LoadingData()
            : SingleChildScrollView(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomContainer(
                        padding: const EdgeInsets.all(10),
                        gradient: LinearGradient(
                          tileMode: TileMode.mirror,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorConstant.gradientLightGreen,
                            ColorConstant.gradientLightblue
                          ],
                        ),
                        child: Column(
                          children: [
                            HeadingOne(
                              fontSize: widths / 20,
                              textColor: ColorConstant.darkBlackColor,
                              Title: "Selected Ride details",
                            ),
                            const Divider(),
                            SubTitle_Text(
                              alignment: Alignment.centerLeft,
                              Title: "From-  ${widget.Needhelpfor!.pickupName}",
                            ),
                            SubTitle_Text(
                              alignment: Alignment.centerLeft,
                              Title: "To-  ${widget.Needhelpfor!.dropName}",
                            ),
                            SubTitle_Text(
                              alignment: Alignment.centerLeft,
                              Title: "Date&Time-  ${widget.Needhelpfor!.pickupDate.substring(0,9)},  ${widget.Needhelpfor!.pickupTime}",
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 10,
                    ),
                    HeadingOne(
                      fontSize: widths / 20,
                      textColor: ColorConstant.darkBlackColor,
                      Title: "Choose Issue Type",
                    ),
                    const Divider(),
                    GlobalCallClass.TripTicketTypes!.status == 1
                        ? Column(
                            children: List.generate(
                                GlobalCallClass.TripTicketTypes!.data[0].details.length,
                                    (index) {
                                      final TicketType =
                                      GlobalCallClass.TripTicketTypes!.data[0].details[index];
                              return Card(
                                color: ColorConstant.gradientLightGreen,
                                child: ListTile(
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  onTap: () {
                                    setState(() {
                                      isSelectedType =
                                          TicketType.tktTypeDetailId;
                                    });
                                    print(TicketType);
                                    print(widget.Needhelpfor!.id);
                                    print(TicketType.tktTypeDetailDescription);
                                    showDialog(
                                      barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext context) =>
                                            BookingRelatedPopUp(
                                                TicketType: TicketType,
                                            ordId:widget.Needhelpfor!.id.toString(),
                                                description:TicketType.tktTypeDetailDescription
                                            ));
                                  },
                                  leading: isSelectedType ==
                                          TicketType.tktTypeDetailId
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
                          )
                        :
                    const NoDataAvailable(),
                  ],
                ),
              ));
  }
}

// to show text box for the selection of different boxes accorind to need
// driver beaviour = 1
// vehicle not clean = 2
// Ac not work = 3
