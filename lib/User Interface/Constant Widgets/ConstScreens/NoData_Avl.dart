import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/main.dart';
import 'package:flutter/material.dart';

import '../../../Constant/assets.dart';

class NoDataAvailable extends StatelessWidget {
  final String? title;
  const NoDataAvailable({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomContainer(
            height: height/3.2,
            width: width/1.5,
            image: const DecorationImage(
                image: AssetImage(
                  Graphics.noData,
                ),
                fit: BoxFit.cover),

          ),
          TitleStyle(
            textAlign: TextAlign.center,
            alignment: Alignment.bottomCenter,
            textColor: ColorConstant.greyColor,
            Title:title??"No data available",
          ) ,
        ],
      ),
    );
  }
}
