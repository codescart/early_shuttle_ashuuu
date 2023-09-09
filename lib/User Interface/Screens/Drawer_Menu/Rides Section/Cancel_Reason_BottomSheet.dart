
// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Text%20Field/TextField_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/Utils/message_utils.dart';
import 'package:flutter/material.dart';
import '../../../../API/Rides_Section/CancelRide_Api.dart';
import '../../../../API/Rides_Section/ReasonsDialogList_Api.dart';
import '../../../../Constant/assets.dart';
import '../../../../Models/HelpSection_Model/ReasonsDialog_Model.dart';
import '../../../../Models/My_RidesSection/CurrentRides_Model.dart';
import '../../../../main.dart';
import '../../../Constant Widgets/ConstScreens/loadingScreen.dart';
import '../../../Constant Widgets/TextStyling/subtitleStyle.dart';

class CancelReason extends StatefulWidget {
  final CurrentRideItem? selectedData;
   const CancelReason({Key? key, this.selectedData,}) : super(key: key);

  @override
  State<CancelReason> createState() => _CancelReasonState();
}

class _CancelReasonState extends State<CancelReason> {
  final otherReason = TextEditingController();

   var selValue;

  String? selectedReason;
  String? selectedReasonId;
  bool isLastSelected= false;

  @override
  Widget build(BuildContext context) {
    final heights =MediaQuery.of(context).size.height;
    final widths =MediaQuery.of(context).size.width;
    return Dialog(
      child: SingleChildScrollView(
        child: CustomContainer(
          borderRadius: BorderRadius.circular(20),
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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.cancel_outlined, color: Colors.red,))
                ],
              ),
              TitleStyle(
                textColor: ColorConstant.darkBlackColor,
                padding: const EdgeInsets.only(left: 15, right: 15),
                alignment: Alignment.centerLeft,
                Title: "Select reason to process the ticket cancellation.",
              ),
              const Divider(),
              CustomContainer(
                height: heights/3.5,
                child: FutureBuilder<DialogReasonsModelsResponse>(
                  future: fetchDialogMessageListData("cancellation"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingData();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: CustomContainer(
                          color: ColorConstant.whiteColor,
                          height: height,
                          child: Image(
                            image: const AssetImage(
                              Graphics.nonotify,
                            ),
                            width: widths / 2,
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return  Center(
                        child: CustomContainer(
                          color: ColorConstant.whiteColor,
                          height: height,
                          child: Image(
                            image: const AssetImage(
                              Graphics.nonotify,
                            ),
                            width: widths / 2,
                          ),
                        ),
                        // CircularProgressIndicator()
                      );
                    } else {
                      final ReasonResponse = snapshot.data!.data;
                      return ListView.builder(
                          itemCount: ReasonResponse.length,
                          itemBuilder: (context, index) {
                            final Reasons =ReasonResponse[index];
                            return CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: SubTitle_Text(
                                alignment: Alignment.centerLeft,
                                Title: Reasons.rescheduleReason,
                              ),
                              value: selectedReason == Reasons.rescheduleReason,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value != null && value) {
                                    selectedReason = Reasons.rescheduleReason;
                                    selectedReasonId= Reasons.ticketTypeDetailId.toString();
                                    if(selectedReasonId.toString()==ReasonResponse.last.ticketTypeDetailId.toString()){
                                      setState(() {
                                        isLastSelected=true;
                                      });
                                    }
                                    else{}
                                  } else {
                                    selectedReason = null;
                                  }
                                });
                              },
                            );
                          });
                    }
                  },
                ),
              ),
              isLastSelected == true ?
              CustomTextField(
                controller: otherReason,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.only(left: 15, right: 15),
                label: "Write here",
                maxLines: 4,
                height: 80,
              ):const SizedBox(),
              const SizedBox(height: 15,),
              PrimaryButton(
                onTap: (){
                  if(selectedReason == null){
                    Utils.flushBarErrorMessage("Select a valid reason to process the cancellation", context);
                  }
                  else{
                    if(isLastSelected==false){
                      Navigator.pop(context);
                      CancelCurrentRide(context,widget.selectedData!.id.toString(), selectedReasonId.toString(), selectedReason.toString());
                    }
                    else{
                      if(otherReason.text.isNotEmpty){
                        Navigator.pop(context);
                        CancelCurrentRide(context,widget.selectedData!.id.toString(), selectedReasonId.toString(), selectedReason.toString());
                      }
                      else{
                        Utils.flushBarErrorMessage("Must be fill your reason", context);
                      }
                    }
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(builder: (context)=> TimeSlotTab(
                    //       navigateStatus: '2',
                    //       orderId:widget.cancelRideData.,
                    //       busScheduleId:cancelRideData.busScheduleId.toString(),
                    //       srcStop:cancelRideData.pickupName,
                    //       desStop:cancelRideData.dropName,
                    //       routeName:"${cancelRideData.routeName}",
                    //       routeId:"${cancelRideData.routeId}",
                    //       stopId:cancelRideData.pickup.toString(),
                    //       pickupId:cancelRideData.pickup.toString(),
                    //       dropId:cancelRideData.drop.toString(),
                    //     )));
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context)=> TimeSlotTab(
                    //       navigateStatus: '2',
                    //       orderId:widget.rescheduleRideData.id.toString(),
                    //       busScheduleId:widget.rescheduleRideData.busScheduleId.toString(),
                    //       srcStop:widget.rescheduleRideData.pickupName,
                    //       desStop:widget.rescheduleRideData.dropName,
                    //       // routeName:widget.rescheduleRideData.,
                    //       routeId:widget.rescheduleRideData.routeId.toString(),
                    //       stopId:widget.rescheduleRideData.pickup.toString(),
                    //       pickupId:widget.rescheduleRideData.pickup.toString(),
                    //       dropId:widget.rescheduleRideData.drop.toString(),
                    //     )));
                  }

                },
                width:widths/2 ,
                Label: "Continue",
                margin: const EdgeInsets.only(left: 15,right: 15, top: 10, bottom: 20),
              )
              // Add more options as needed
            ],
          ),
        ),
      ),
    );
  }
}
