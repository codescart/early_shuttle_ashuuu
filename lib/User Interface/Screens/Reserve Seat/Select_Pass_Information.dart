import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Models/Pass_Section/Purchase_Pass_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Coupon/CouponsScreen.dart';
import 'package:flutter/material.dart';

import '../../../API/Coupons/UserCoupons_Api.dart';
import '../../../API/Pass_Section/PurchasePassOrder_Api.dart';
import '../../../Models/CouponsModel/UserCoupons_Model.dart';
import '../../Constant Widgets/Buttons/PrimaryButton.dart';

class SelectPassInfo extends StatefulWidget {
  final RouteFare selectedPassData;
  const SelectPassInfo({Key? key, required this.selectedPassData }) : super(key: key);

  @override
  State<SelectPassInfo> createState() => _SelectPassInfoState();
}

class _SelectPassInfoState extends State<SelectPassInfo> {
  CouponResponse? couponData;


  checkCouponData() async {
    final data = await fetchUserCouponsData();
    print(data!.status);
    setState(() {
      couponData= data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkCouponData();
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leadingWidth: 50,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 20,color: ColorConstant.whiteColor,),),
        title:  HeadingOne(
          Title: "Selected Pass Information",
          fontSize: 25,
        ),
      ),
      body: CustomContainer(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CustomContainer(
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
              margin: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(5),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TitleStyle(
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w600,
                    textColor: ColorConstant.darkBlackColor,
                    Title: "Route 1:",
                  ),
                  SubTitle_Text(
                    Title:widget.selectedPassData.urouteName,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  TitleStyle(
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w600,
                    textColor: ColorConstant.darkBlackColor,
                    Title: "Route 2:",
                  ),
                  SubTitle_Text(
                    Title:widget.selectedPassData.drouteName,
                  ),
                  Divider(),
                  couponData!.data.length != 0? ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CouponsScreen(passType:widget.selectedPassData)));
                    },
                    contentPadding: const EdgeInsets.all(0),
                    title: TitleStyle(
                      alignment: Alignment.centerLeft,
                      fontWeight: FontWeight.w600,
                      textColor: ColorConstant.darkBlackColor,
                      Title: "Coupon Available:",
                    ),
                    trailing: PrimaryButton(
                      width: widths/3 ,
                      margin: EdgeInsets.only(top: 10),
                      color: ColorConstant.darkBlue,
                      textColor: Colors.black,
                      alignment: Alignment.centerLeft,
                      Label: "Apply coupon",
                    ),
                  ):SizedBox(),
                ],
              ),
            ),
            CustomContainer(
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
              margin: EdgeInsets.all(10),
              borderRadius: BorderRadius.circular(5),
              // border: Border.all(width: 1,color: Colors.black),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TitleStyle(
                    fontWeight: FontWeight.w600,
                    alignment: Alignment.centerLeft,
                    textColor: ColorConstant.darkBlackColor,
                    Title:"Pass: ",
                  ),
                  SubTitle_Text(
                    Title: "${widget.selectedPassData.fareType} (Valid for ${widget.selectedPassData.validDays} calender days)",
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubTitle_Text(
                        fontWeight: FontWeight.w600,
                        Title:"Total Amount: ",
                      ),
                      SubTitle_Text(
                        Title:"₹ ${widget.selectedPassData.fare}",
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubTitle_Text(
                        fontWeight: FontWeight.w600,
                        Title:"Amount Payable:",
                      ),
                      SubTitle_Text(
                        Title:"₹ ${widget.selectedPassData.fare}",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomContainer(
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
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              borderRadius: BorderRadius.circular(5),
              child: Column(
                children: [
                  TitleStyle(
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.w600,
                    textColor: ColorConstant.darkBlackColor,
                    Title: "Pay With: ",
                  ),
                  Divider(),
                  ListTile(
                    title:PrimaryButton(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0xff132a53),
                      width: widths,
                      Label: "Paytm",
                      fontSize: widths/20,
                      fontWeight: FontWeight.w900,
                    ),
                    trailing: SubTitle_Text(
                      padding: EdgeInsets.only(right: 10),
                      alignment: FractionalOffset.centerRight,
                      width:widths/3 ,
                      Title:"₹ ${widget.selectedPassData.fare}",
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      // MakeOrderForPurchasePass(amount, urouteId, drouteId, passType, paymentType, promocode, totalAmount);
                    },
                    title: PrimaryButton(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0xff6739B7),
                      width: widths,
                      Label: "Phonepe",
                      fontSize: widths/20,
                      fontWeight: FontWeight.w900,
                    ),
                    trailing: SubTitle_Text(
                          padding: EdgeInsets.only(right: 10),
                          alignment: FractionalOffset.centerRight,
                          width:widths/3 ,
                          Title:"₹ ${widget.selectedPassData.fare}",
                        ) ,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
