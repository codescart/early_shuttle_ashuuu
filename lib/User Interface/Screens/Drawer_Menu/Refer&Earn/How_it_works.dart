import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:flutter/material.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubTitle_Text(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textColor: ColorConstant.darkBlackColor,
                  padding: EdgeInsets.only(left: 15),
                  Title: "How it works".toUpperCase(),
                ),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.cancel_outlined, color: Colors.red,))
              ],
            ),
            ListTile(
              leading: Icon(Icons.stars_rounded, color: ColorConstant.primaryColor,),
              title: SubTitle_Text(
                  alignment: Alignment.centerLeft,
                  Title:'Get 25 Points'
              ),
              subtitle: Small_Text(
                alignment: Alignment.centerLeft,
                Title: "After verification of referal user.",
              ),
              onTap: () {
                // Handle the music selection here
              },
            ),
            ListTile(
              leading: Icon(Icons.stars_rounded, color: ColorConstant.primaryColor,),
              title: SubTitle_Text(
                  alignment: Alignment.centerLeft,
                  Title:'Get 25 Points'
              ),
              subtitle: Small_Text(
                alignment: Alignment.centerLeft,
                Title: "After verification of referal user.",
              ),
              onTap: () {
                // Handle the music selection here
              },
            ),
            ListTile(
              leading: Icon(Icons.stars_rounded, color: ColorConstant.primaryColor,),
              title: SubTitle_Text(
                alignment: Alignment.centerLeft,
                  Title:'2% Commission'
              ),
              subtitle: Small_Text(
                alignment: Alignment.centerLeft,
                Title: "Every time referred user taken ride",
              ),
              onTap: () {
                // Handle the music selection here
              },
            ),
            SizedBox(height: 20,)
            // Add more options as needed
          ],
        ),
      ),
    );
  }
}
