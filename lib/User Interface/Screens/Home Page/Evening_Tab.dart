// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Text%20Field/TextField_widget.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/CurrentRide.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/Image_Slider.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/QuickBook.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/SearchForStops.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/Text_Banner.dart';
import 'package:early_shuttle/User%20Interface/Screens/SelectRoute/Selecet_route.dart';
import 'package:early_shuttle/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../Constant/color.dart';
import '../../../Models/HomePage_Sections/QuickBook_Model.dart';
import '../../../Models/HomePage_Sections/Text_Slider_Model.dart';
import '../../../Utils/message_utils.dart';

class Evening_Tab extends StatefulWidget {
  final QuickBook? QuickBookView;
  final BannerResponse? bannerData;
  const Evening_Tab({Key? key, this.QuickBookView, this.bannerData,}) : super(key: key);

  @override
  State<Evening_Tab> createState() => _Evening_TabState();
}

class _Evening_TabState extends State<Evening_Tab> {
  final from= TextEditingController();
  final to= TextEditingController();

  String fromLocation = '';
  String toLocation = '';
  double fromLatitude = 0.0;
  double fromLongitude = 0.0;
  double toLatitude = 0.0;
  double toLongitude = 0.0;

  void _selectLocation(String locationType) async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchForPage(locationType: locationType),
      ),
    );

    if (selectedLocation != null && selectedLocation is Map<String, dynamic>) {
      setState(() {
        if (locationType == 'from') {
          fromLocation = selectedLocation['locationName'];
          fromLatitude = selectedLocation['latitude'];
          fromLongitude = selectedLocation['longitude'];
          if (kDebugMode) {
            print("from locations");
            print(fromLocation);
            print(fromLatitude);
            print(fromLongitude);
          }
        } else if (locationType == 'to') {
          toLocation = selectedLocation['locationName'];
          toLatitude = selectedLocation['latitude'];
          toLongitude = selectedLocation['longitude'];
        }
      });
    }
  }
  var heights;
  var widths;
  @override
  Widget build(BuildContext context) {
    heights = MediaQuery.of(context).size.height;
    widths = MediaQuery.of(context).size.width;
    return CustomContainer(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
      gradient: LinearGradient(
        tileMode: TileMode.mirror,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          ColorConstant.gradientLightGreen,
          ColorConstant.gradientLightblue
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FindRoutes(context),
            const SizedBox(height: 10,),
            const CurrentRideScreen(),
            QuickBookScreen(Navtype:"2",QuickBookView:widget.QuickBookView),
            SizedBox(height: heights/60,),
            TextSlider_Banner(bannerData:widget.bannerData),
            SizedBox(height: heights/60,),
            HomePageImageSlider()
          ],
        ),
      ),
    );
  }

  Widget FindRoutes(BuildContext context){
    return CustomContainer(
      padding: const EdgeInsets.only(left: 5, top: 15, right: 5,bottom: 15),
      width: widths,
      color: ColorConstant.whiteColor,
      border: Border.all(width: 0.5, color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: widths/10,
                child: Column(
                  children: [
                    Image.asset(Graphics.orangeRound, width: width/18,),
                    Transform.rotate(
                        angle:3.15 ,
                        child: Icon(Icons.straight, size: width/10,)),
                    Image.asset(Graphics.bluePin, width: width/25,)
                  ],
                ),
              ),
              Column(
                children: [
                  CustomTextField(
                    fontSize: 12,
                    controller: from..text=fromLocation,
                    enabled: false,
                    onTap: (){
                      _selectLocation('from');
                    },
                    border: Border.all(width: 0.5, color: ColorConstant.greyColor.withOpacity(0.5)),
                    fieldRadius: BorderRadius.circular(5),
                    borderRadius: BorderRadius.circular(5),
                    width: widths/1.5,
                    filled: true,
                    fillColor: ColorConstant.whiteColor,
                    label:"Pickup Near Office",
                  ),
                  SizedBox(height: heights/50,),
                  CustomTextField(
                    fontSize: 12,
                    controller: to..text= toLocation,
                    enabled: false,
                    onTap: (){
                      _selectLocation('to');
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchForPage()));
                    },
                    border: Border.all(width: 0.5, color: ColorConstant.greyColor.withOpacity(0.5)),
                    fieldRadius: BorderRadius.circular(5),
                    borderRadius: BorderRadius.circular(5),
                    width: widths/1.5,
                    filled: true,
                    fillColor: ColorConstant.whiteColor,
                    label:"Drop Near Home",
                  ),
                ],
              ),
              SwapAddress(),
            ],
          ),
          SizedBox(height: heights/40,),
          PrimaryButton(
            width: widths/1.6,
            onTap: (){
              if(fromLocation !="" && toLocation !=""){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  Select_route(fromLatitude: fromLatitude.toString(), fromLongitude: fromLongitude.toString(), toLatitude:toLatitude.toString(),
                  toLongitude: toLongitude.toString(),routeType:"evening")),);
              }
              else{
                Utils.flushBarErrorMessage("Pickup and Drop location is required to continue", context);
              }
            },
            Label: "Find Route",
            icon: Icons.save,
            textColor: ColorConstant.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ColorConstant.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget SwapAddress(){
    return CustomContainer(
        onTap: (){
          if(from.text == fromLocation && to.text == toLocation){
            if (kDebugMode) {
              print("interchange");
            }
            from.text = toLocation;
            to.text = fromLocation;
          }
          else if(from.text == toLocation && to.text == fromLocation){
            if (kDebugMode) {
              print("same same");
            }
            from.text = fromLocation;
            to.text = toLocation;
          }
        },
        alignment: Alignment.centerLeft,
        width:widths/10,
        child:  Icon(Icons.swap_vert,color: ColorConstant.darkBlackColor,size: 35,)
    );

  }
}
