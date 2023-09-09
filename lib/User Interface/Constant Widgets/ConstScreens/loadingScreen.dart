import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/main.dart';
import 'package:flutter/material.dart';

import '../../../Constant/assets.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: ColorConstant.whiteColor,
      height: height, width: width,
      child: Image(image: AssetImage(Graphics.loading,),width: width/2,),
    );
  }
}
