import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Models/Pass_Section/Purchase_Pass_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Reserve%20Seat/Select_Pass_Information.dart';
import 'package:flutter/material.dart';
import '../../../../Constant/color.dart';
import '../../../../main.dart';
import '../../../Constant Widgets/Container/Container_widget.dart';
import '../../../Constant Widgets/TextStyling/RichText.dart';
import '../../../Constant Widgets/TextStyling/titleStyle.dart';

class SelectedPassInformation extends StatefulWidget {
  final List<RouteFare> purchase;
  SelectedPassInformation({required this.purchase});

  @override
  State<SelectedPassInformation> createState() =>
      _SelectedPassInformationState();
}

class _SelectedPassInformationState extends State<SelectedPassInformation> {
  int _selectedItem = -1;
  void _handleItemChanged(int index) {
    setState(() {
      if (_selectedItem == index) {
        _selectedItem = -1; // Deselect the item if it's already selected
      } else {
        _selectedItem = index;
      }
    });
  }

  int? selectedRouteIndex;
  RouteFare? Data;

  // int? selectedRouteIndex;
  RouteFare? selectedData;
  bool isSwapped = false;

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
          Title: "Selected Pass",
          fontSize: 25,
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.change_circle_outlined,size: 30,), color: ColorConstant.whiteColor,),
          SizedBox(width: 5,)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomContainer(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedPassInformation()));
                },
                color: ColorConstant.whiteColor,
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
                      offset: const Offset(0, 3),
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 2,
                      spreadRadius: 1)
                ],
                margin: const EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(5),
                // border: Border.all(width: 1,color: Colors.black),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRichText(
                          textSpans: [
                            CustomTextSpan(
                                text: 'Distance:  \n',
                                fontWeight: FontWeight.bold),
                            CustomTextSpan(
                              text: widget.purchase!.first.distance,
                            ),
                          ],
                        ),
                        CustomRichText(
                          textAlign: TextAlign.right,
                          textSpans: [
                            CustomTextSpan(
                                text: 'Estimated Time of Arrival \n',
                                fontWeight: FontWeight.bold),
                            CustomTextSpan(
                              text: widget.purchase!.first.eta,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomContainer(
                          width: width / 1.4,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              SubTitle_Text(
                                alignment: Alignment.centerLeft,
                                fontWeight: FontWeight.bold,
                                Title: isSwapped == false? "Route: ${widget.purchase.first.urouteId}": "Route: ${widget.purchase.first.drouteId}",
                              ),
                              SubTitle_Text(
                                alignment: Alignment.centerLeft,
                                Title: isSwapped == false
                                    ? widget.purchase!.first.urouteName
                                    : "${widget.purchase!.first.drouteName}",
                              ),
                              const Divider(
                                color: Colors.grey,
                                indent: 5,
                              ),
                              SubTitle_Text(
                                alignment: Alignment.centerLeft,
                                fontWeight: FontWeight.bold,
                                Title:isSwapped == false? "Route: ${widget.purchase.first.drouteId}": "Route: ${widget.purchase.first.urouteId}",
                              ),
                              SubTitle_Text(
                                alignment: Alignment.centerLeft,
                                Title: isSwapped == false
                                    ? "${widget.purchase!.first.drouteName}"
                                    : "${widget.purchase!.first.urouteName}",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        SwapAddress()
                      ],
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // PrimaryButton(
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    //   Label: "Change Route",
                    // ),
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
                      offset: const Offset(0, 3),
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 2,
                      spreadRadius: 1)
                ],
                margin: const EdgeInsets.all(10),
                borderRadius: BorderRadius.circular(5),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleStyle(
                      textColor: ColorConstant.darkBlackColor,
                      Title: "Select pass type",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomContainer(
                      color: ColorConstant.whiteColor,
                      child: Row(
                        children: [
                          CustomContainer(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: width / 2.6,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5)),
                            border: Border.all(
                                width: 1, color: ColorConstant.darkBlackColor),
                            child: SubTitle_Text(
                              textAlign: TextAlign.center,
                              Title: "Pass Type",
                              fontWeight: FontWeight.w600,
                              textColor: ColorConstant.blueColor,
                            ),
                          ),
                          CustomContainer(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: width / 4.5,
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                                width: 1, color: ColorConstant.darkBlackColor),
                            child: SubTitle_Text(
                              textAlign: TextAlign.center,
                              Title: "Validity",
                              fontWeight: FontWeight.w600,
                              textColor: ColorConstant.blueColor,
                            ),
                          ),
                          CustomContainer(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: width / 4.5,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            border: Border.all(
                                width: 1, color: ColorConstant.darkBlackColor),
                            child: SubTitle_Text(
                              textAlign: TextAlign.center,
                              Title: "Price",
                              fontWeight: FontWeight.w600,
                              textColor: ColorConstant.blueColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                        children:
                            List.generate(widget.purchase.length, (index) {
                      final data = widget.purchase[index];
                      return CustomContainer(
                        onTap: () {
                          setState(() {
                            Data = widget.purchase[index];
                          });
                        },
                        margin: EdgeInsets.only(bottom: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                        border: Data != widget.purchase[index]
                            ? Border.all(
                                width: 0.4,
                                color: ColorConstant.greyColor.withOpacity(0.8))
                            : Border.all(
                                width: 1,
                                color: ColorConstant.darkBlackColor
                                    .withOpacity(0.8)),
                        color: Data == widget.purchase[index]
                            ? ColorConstant.whiteColor:Colors.transparent,
                        child: Row(children: [
                          CustomContainer(
                            borderRadius: BorderRadius.circular(0),
                            width: width / 2.7,
                            child: Small_Text(
                              textAlign: TextAlign.center,
                              Title: data.fareType,
                            ),
                          ),
                          CustomContainer(
                            borderRadius: BorderRadius.circular(0),
                            width: width / 4.6,
                            child: Small_Text(
                              textAlign: TextAlign.center,
                              Title: "${data.validDays.toString()} days",
                            ),
                          ),
                          CustomContainer(
                              borderRadius: BorderRadius.circular(0),
                              padding: EdgeInsets.only(left: 15),
                              width: width / 4.6,
                              child:Data == widget.purchase[index]
                                  ?
                              Row(
                                children: [
                                  Small_Text(
                                    textAlign: TextAlign.center,
                                    Title: "₹ ${data.fare}",
                                  ),
                                  Spacer(),
                                  Icon(Icons.check_circle, color:ColorConstant.blueColor,size: 18,)
                                ],
                              ): Small_Text(
                                textAlign: TextAlign.center,
                                Title: "₹ ${data.fare}",
                              ),
                          ),
                          // CustomContainer(
                          //   borderRadius: BorderRadius.circular(0),
                          //   width: width/4.8,
                          //   child: Checkbox(
                          //     activeColor: ColorConstant.primaryColor,
                          //     value: selectedRouteIndex == index,
                          //     onChanged: (value) {
                          //       setState(() {
                          //         Data =  widget.purchase[index];
                          //         selectedRouteIndex = value! ? index : null;
                          //       });
                          //     },
                          //   ),
                          // ),
                        ]),
                      );
                    }))
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Data != null
          ? PrimaryButton(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SelectPassInfo(selectedPassData: Data!)));
              },
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 25, top: 15),
              Label: "Next",
            )
          : SizedBox(),
    );
  }

  Widget SwapAddress() {
    return CustomContainer(
        onTap: () {
          if (isSwapped == false) {
            setState(() {
              isSwapped = true;
            });
          } else if (isSwapped == true) {
            setState(() {
              isSwapped = false;
            });
          }
        },
        alignment: Alignment.centerLeft,
        width: width / 10,
        child: isSwapped == false
            ? Icon(
                Icons.swap_vert,
                color: ColorConstant.darkBlackColor,
                size: 35,
              )
            : Transform.rotate(
                angle: 9.4,
                child: Icon(
                  Icons.swap_vert,
                  color: ColorConstant.blueColor,
                  size: 35,
                ),
              ));
  }
}
