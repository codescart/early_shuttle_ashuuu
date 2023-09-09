import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Constant/global_call.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/NoData_Avl.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/color.dart';

class PassHistory extends StatefulWidget {
  const PassHistory({Key? key}) : super(key: key);

  @override
  State<PassHistory> createState() => _PassHistoryState();
}

class _PassHistoryState extends State<PassHistory> {


  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return GlobalCallClass.ViewPassHistoryData==null?
        NoDataAvailable(title: "Pass history not available",):
      ListView.builder(
        itemCount: GlobalCallClass.ViewPassHistoryData!.data.passes.length,
        itemBuilder:(context, index){
          final PassDetail= GlobalCallClass.ViewPassHistoryData!.data.passes[index];
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
            // border: Border.all(width: 1,color: Colors.black),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubTitle_Text(
                      Title: PassDetail.id.toString(),
                    ),
                    SubTitle_Text(
                      Title: "${PassDetail.passType} Pass",
                    ),
                    PrimaryButton(
                      textColor: ColorConstant.whiteColor,
                      fontSize: 13,
                      width: widths/4.5,
                      Label: "Buy Again",
                    )
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
                      Title: "Route No- ${PassDetail.urouteId}, ${PassDetail.routeName}",
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
                          Title:PassDetail.rides.toString(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Small_Text(
                          Title: "Used",
                        ),
                        Small_Text(
                          Title: PassDetail.avail.toString(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Small_Text(
                          Title: "Remaining",
                        ),
                        Small_Text(
                          Title: PassDetail.remaining.toString(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Small_Text(
                          Title: "Expiry On",
                        ),
                        Small_Text(
                          Title: PassDetail.expireOn.substring(0,10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class RouteList {
  final String CNo;
  final String Nrides;
  final String Used;
  final String remain;
  final String exp;
  final String route;

  RouteList(this.CNo, this.Nrides, this.Used, this.remain, this.exp, this.route);
}