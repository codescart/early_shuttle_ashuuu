
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/Text_Button.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/HomePage.dart';
import 'package:early_shuttle/main.dart';
import 'package:flutter/material.dart';

import '../../../Constant/assets.dart';
import '../../../generated/assets.dart';

class FullPageNotification extends StatelessWidget {
  final String message;

  FullPageNotification({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: AssetImage(Graphics.appIcon, ),width: width/5,),
          SizedBox(height: 20,),
          CustomContainer(
            width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.5,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(Assets.assetsFullScr),
                fit: BoxFit.cover
              ),
          ),
          SizedBox(height: 15,),
          PrimaryButton(
            onTap: (){
              Navigator.of(context).pop();
              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Homepage()));
            },
            color: Colors.red.shade600,
            fontSize: width/20,
            width: width/5,
            Label: "close",
          )
        ],
      ),
    );
  }
}
