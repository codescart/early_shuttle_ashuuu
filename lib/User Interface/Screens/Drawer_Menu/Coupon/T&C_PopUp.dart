import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:flutter/material.dart';

class TandCPupUp extends StatefulWidget {
  const TandCPupUp({Key? key}) : super(key: key);

  @override
  State<TandCPupUp> createState() => _TandCPupUpState();
}

class _TandCPupUpState extends State<TandCPupUp> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.bounceOut,
      child: CustomContainer(
        padding: EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(10),
         color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleStyle(
              textColor: ColorConstant.darkBlackColor,
              alignment: Alignment.center,
              Title: "Terms and Conditions",
            ),
            SizedBox(height: 10,),
            Small_Text(
              Title: "By accessing or using our website [YourWebsite.com] (the \"Service\"), you agree to comply with and be bound by these Terms and Conditions."
                  "\nIf you do not agree to these terms, please do not use our Service. \nYou may use our Service for personal, non-commercial purposes only. You agree not to engage in any unlawful or prohibited activities while using the Service.",
            )
          ],
        ),
      ),
    );
  }
}
