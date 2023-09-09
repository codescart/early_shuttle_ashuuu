// ignore_for_file: empty_catches, prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously

import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Explore_Route/Explore_Routes_List.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/New_Location_PopUp.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Suggest_New_Location_Map.dart';
import 'package:flutter/material.dart';

import '../../../../API/Help_Section/TripRelatedTickets_Api.dart';
import '../../../../Constant/global_call.dart';
import '../../../../Models/HelpSection_Model/TripRelated_Model.dart';

class ServiceAreaTiming extends StatefulWidget {
  const ServiceAreaTiming({Key? key}) : super(key: key);

  @override
  State<ServiceAreaTiming> createState() => _ServiceAreaTimingState();
}

class _ServiceAreaTimingState extends State<ServiceAreaTiming> {
  var selectedOption;
  var isSeleted;

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
    return GlobalCallClass.TripTicketTypes!.data.isEmpty
        ? const Scaffold(
            body: LoadingData(),
          )
        : Scaffold(
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
                Title: GlobalCallClass.TripTicketTypes!.data[2].type,
                fontSize: 25,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                        GlobalCallClass.TripTicketTypes!.data[2].details.length,
                        (index) {
                      final TicketType = GlobalCallClass
                          .TripTicketTypes!.data[2].details[index];
                      return Card(
                        color: ColorConstant.gradientLightGreen,
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          onTap: () {
                            setState(() {
                              isSelectedType =
                                  TicketType.tktTypeDetailDescription;
                            });
                            if (index == 0) {
                              _selectLocation(TicketType);
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>MapForNewLocation(
                              //   selectedTicketData: TicketType,
                              // )));
                            }
                            if (index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExploreRouteList(
                                            selectedTicketData: TicketType,
                                          )));
                            }

                            // showDialog(
                            //     barrierDismissible: false,
                            //     context: context,
                            //     builder: (BuildContext context) =>
                            //         BookingRelatedPopUp(
                            //             TicketType: TicketType,
                            //             // ordId:widget.Needhelpfor!.id.toString(),
                            //             description:
                            //             TicketType.tktTypeDetailDescription));
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

  //------------------------------------------
  var suggestedlocationName;
  void _selectLocation(HelpDetail? TicketType) async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapForNewLocation(
          selectedTicketData: TicketType,
        ),
      ),
    );

    if (selectedLocation != null && selectedLocation is Map<String, dynamic>) {
      setState(() {
        suggestedlocationName = selectedLocation['locationName'];
      });
      if (suggestedlocationName != null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return New_Location_PopUp(
                  selectedTicketData: TicketType,
                  suggestlocation: suggestedlocationName);
            });
      }
    }
  }
}

// to show text box for the selection of different boxes accorind to need
// driver beaviour = 1
// vehicle not clean = 2
// Ac not work = 3
