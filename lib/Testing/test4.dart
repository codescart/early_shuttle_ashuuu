import 'package:early_shuttle/Models/Pass_Section/Purchase_Pass_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/main.dart';
import 'package:flutter/material.dart';

import '../Constant/color.dart';

class SelectedPassDataTable extends StatefulWidget {
  final List<RouteFare> purchase;
  const SelectedPassDataTable({Key? key, required this.purchase})
      : super(key: key);

  @override
  State<SelectedPassDataTable> createState() => _SelectedPassDataTableState();
}

class _SelectedPassDataTableState extends State<SelectedPassDataTable> {
  int? selectedRouteIndex;
  RouteFare? selectedData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomContainer(
                width: width/4.3,
                borderRadius: BorderRadius.circular(0),
                color: Colors.green,
                border: Border.all(width: 0.5, color: ColorConstant.darkBlackColor),
                child:SubTitle_Text(
                  Title: "Pass Type",
                  fontWeight: FontWeight.w600,
                ) ,
              ),
              CustomContainer(
                width: width/4.3,
                borderRadius: BorderRadius.circular(0),
                color: Colors.green,
                border: Border.all(width: 0.5, color: ColorConstant.darkBlackColor),
                child:SubTitle_Text(
                  Title: "Valid (days)",
                  fontWeight: FontWeight.w600,
                ) ,
              ),
              CustomContainer(
                width: width/4.3,
                borderRadius: BorderRadius.circular(0),
                color: Colors.green,
                border: Border.all(width: 0.5, color: ColorConstant.darkBlackColor),
                child:SubTitle_Text(
                  Title: "Price",
                  fontWeight: FontWeight.w600,
                ) ,
              ),
              CustomContainer(
                width: width/4.3,
                borderRadius: BorderRadius.circular(0),
                color: Colors.green,
                border: Border.all(width: 0.5, color: ColorConstant.darkBlackColor),
                child:SubTitle_Text(
                  Title: "Select",
                  fontWeight: FontWeight.w600,
                ) ,
              ),
            ],
          ),
          Column(
              children: List.generate(
                widget.purchase.length,
                    (index) => Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer(
                        borderRadius: BorderRadius.circular(0),
                        width: width/4.3,
                        color: Colors.green,
                        border: Border.all(width: 0.5, color: ColorConstant.darkBlackColor),
                        child:SubTitle_Text(
                          Title: widget.purchase[index].fareType,
                        ) ,
                      ),
                      CustomContainer(
                        borderRadius: BorderRadius.circular(0),
                        width: width/4.3,
                        color: Colors.green,
                        border: Border.all(width: 0.5, color: ColorConstant.darkBlackColor),
                        child:SubTitle_Text(
                          Title: widget.purchase[index].validDays.toString(),
                        ) ,
                      ),
                      CustomContainer(
                        borderRadius: BorderRadius.circular(0),
                        width: width/4.3,
                        color: Colors.green,
                        border: Border.all(width: 0.5, color: ColorConstant.darkBlackColor),
                        child:SubTitle_Text(
                          Title: "₹ ${widget.purchase[index].fare}",
                        ) ,
                      ),
                      CustomContainer(
                        borderRadius: BorderRadius.circular(0),
                        width: width/4.3,
                        color: Colors.green,
                        border: Border.all(width: 0.5, color: ColorConstant.darkBlackColor),
                        child: Checkbox(
                          value: selectedRouteIndex == index,
                          onChanged: (value) {
                            setState(() {
                              selectedData = widget.purchase[index];
                              selectedRouteIndex = value! ? index : null;
                            });
                          },
                        ),
                      ),
                    ]),
              ))
        ],
      ),
    );
  }
}
