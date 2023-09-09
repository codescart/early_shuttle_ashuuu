import 'package:early_shuttle/Models/CouponsModel/UserCoupons_Model.dart';
import 'package:early_shuttle/Models/Pass_Section/Purchase_Pass_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/Text_Button.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Terms%20&%20Condition/T&C_PopUp.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/My%20Pass/Selected_Pass_Information.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../API/Coupons/ApplyCoupon_Api.dart';
import '../../../../API/Coupons/UserCoupons_Api.dart';
import '../../../../Constant/color.dart';
import '../../../Constant Widgets/ConstScreens/NoData_Avl.dart';
import '../../../Constant Widgets/ConstScreens/loadingScreen.dart';
import '../../../Constant Widgets/Container/Container_widget.dart';
import '../../../Constant Widgets/TextStyling/subtitleStyle.dart';

class CouponsScreen extends StatefulWidget {
  final RouteFare? passType;
  const CouponsScreen({Key? key, this.passType, }) : super(key: key);

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leadingWidth: 50,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 20,color: ColorConstant.whiteColor,),),
        title:  HeadingOne(
          Title: "Coupons",
          fontSize: 25,
        ),
      ),
      body: FutureBuilder<CouponResponse?>(
        future: fetchUserCouponsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingData();
          } else if (snapshot.hasError) {
            return const NoDataAvailable();
          } else if (!snapshot.hasData) {
            return const Center(
              child: NoDataAvailable(),
            );
          } else {
            List<CouponInfo> coupon = snapshot.data!.data;
            return ListView.builder(
              itemCount: coupon.length,
                itemBuilder: (context, index) {
                final couponData = coupon[index];
                  return Container(
                    padding: EdgeInsets.only(top: 15, right: 8, left: 8),
                    child: CustomContainer(
                      padding: EdgeInsets.all(8),
                      gradient: LinearGradient(
                        tileMode: TileMode.mirror,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorConstant.gradientLightGreen,
                          ColorConstant.gradientLightblue
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0,3),
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 2,
                            spreadRadius: 1
                        )
                      ],
                      child:  Column(
                        children: [
                          Row(crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage("assets/male3.png"),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SubTitle_Text(textColor:ColorConstant.darkBlackColor,Title: couponData.title,alignment: Alignment.centerLeft,),
                                  Small_Text(
                                    textAlign: TextAlign.justify,
                                    width: widths/1.5,
                                    Title: couponData.subtitle,
                                    padding: EdgeInsets.only(bottom: 0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubTitle_Text(
                                Title: "Expired on:",
                              ),
                              SubTitle_Text(
                                Title: DateFormat.yMMMd().format(couponData.expiryDate),
                                // Title: "Expiries:\n${couponData.expiryDate}",
                                // padding: EdgeInsets.only(bottom: 10),
                              ),
                              PrimaryButton(
                                onTap: (){
                                  ApplyCoupons(context, couponData.urouteId.toString(), couponData.drouteId.toString(),
                                  widget.passType!.fareType, couponData.amountRemaining.toString(), couponData.id.toString()
                                  );
                                },
                                width: widths/3,
                                Label: "Apply Coupon".toUpperCase(),
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Text_Button(
                            onTap: (){
                              showDialog(context: context, builder: (BuildContext context)=>TandCPupUp());
                            },
                            textColor:ColorConstant.blueColor,
                            Title: "Terms & Condition Applied",
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          }
        },
      )
    );
  }
}
