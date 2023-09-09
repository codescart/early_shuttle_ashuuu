// ignore: file_names

// ignore_for_file: file_names, duplicate_ignore, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:early_shuttle/Models/HomePage_Sections/QuickBook_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/NoData_Avl.dart';
import 'package:early_shuttle/User%20Interface/Screens/Reserve%20Seat/TimeSlot_Tab.dart';
import 'package:flutter/material.dart';
import '../../../Constant/assets.dart';
import '../../../Constant/color.dart';
import '../../../main.dart';
import '../../Constant Widgets/Container/Container_widget.dart';
import '../../Constant Widgets/TextStyling/smallTextStyle.dart';
import '../../Constant Widgets/TextStyling/subtitleStyle.dart';

class QuickBookScreen extends StatefulWidget {
  final String? Navtype;
  final QuickBook? QuickBookView;
  const QuickBookScreen({Key? key, this.Navtype, this.QuickBookView}) : super(key: key);

  @override
  State<QuickBookScreen> createState() => _QuickBookScreenState();
}

class _QuickBookScreenState extends State<QuickBookScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuickBookData? LastRideData;
  if(widget.Navtype=="1"){
    setState(() {
      LastRideData =  widget.QuickBookView!.data.first;
    });
  }
  else{
    setState(() {
      LastRideData =  widget.QuickBookView!.data.last;
    });
  }

    return LastRideData == null?
        const NoDataAvailable():
      CustomContainer(
      color: ColorConstant.whiteColor,
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubTitle_Text(
                padding: const EdgeInsets.only(left: 10),
                Title: "Quick Book for "+LastRideData!.pickupTime.toString(),
                fontWeight: FontWeight.w600,
              ),
              PrimaryButton(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TimeSlotTab(
                    navigateStatus:"1",
                    srcStop:LastRideData!.pickupName,
                    desStop:LastRideData!.dropName,
                    routeName:LastRideData!.routeName,
                    routeId:LastRideData!.routeId.toString(),
                    stopId:LastRideData!.pickup.toString(),
                    pickupId:LastRideData!.pickup.toString(),
                    dropId:LastRideData!.drop.toString(),
                  ) ));
                },
                color: ColorConstant.darkBlue,
                padding: const EdgeInsets.all(2),
                width: width/3.5,
                height: 40,
                Label: "Reserve Seat",
                textColor: ColorConstant.whiteColor,
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(Graphics.orangeRound, scale: height/50,),
                  Transform.rotate(
                      angle:3.15 ,
                      child: Icon(Icons.straight, size: height/35,)),
                  Image.asset(Graphics.bluePin, scale: height/40,)
                ],
              ),
              const SizedBox(width: 10,),
              Column(
                children: [
                  Small_Text(
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    width: width/1.4,
                    Title: LastRideData!.pickupName.toString(),
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 20,),
                  Small_Text(
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    width: width/1.4,
                    Title: LastRideData!.dropName,
                    textColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Small_Text(
            Title:"Route- ${LastRideData!.routeId}, ${LastRideData!.routeName.toString()}",
          ),
        ],
      ),
    );
  }
}
