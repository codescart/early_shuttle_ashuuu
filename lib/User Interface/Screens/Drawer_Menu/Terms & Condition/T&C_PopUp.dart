import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Models/Pass_Section/T_C_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:flutter/material.dart';

import '../../../../API/Pass_Section/PassT_C_Api.dart';

class TandCPupUp extends StatefulWidget {
  const TandCPupUp({Key? key}) : super(key: key);

  @override
  State<TandCPupUp> createState() => _TandCPupUpState();
}

class _TandCPupUpState extends State<TandCPupUp> {

  @override
  void initState() {
    fetchPassTermData();
    super.initState();
  }
  PassT_C? Terms;
 fetchPassTermData() async {
    try {
      final data = await fetchPassTCData();
      setState(() {
        Terms = data;
      });
    } catch (error) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.bounceOut,
      child: CustomContainer(
        padding: const EdgeInsets.only(bottom: 25,left: 10, right: 10),
        borderRadius: BorderRadius.circular(10),
         color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.cancel_outlined, color: Colors.red,)),
            TitleStyle(
              textColor: ColorConstant.darkBlackColor,
              alignment: Alignment.center,
              Title: "Terms and Conditions",
            ),
            const Divider(),
            SubTitle_Text(
              alignment: Alignment.centerLeft,
              Title: Terms!.cond1.toString()
            ),
            const SizedBox(height: 5,),
            SubTitle_Text(
                alignment: Alignment.centerLeft,
                Title: Terms!.cond2.toString()
            ),
            const SizedBox(height: 5,),
            SubTitle_Text(
                alignment: Alignment.centerLeft,
                Title: Terms!.cond3.toString()
            ),
            const SizedBox(height: 5,),
            SubTitle_Text(
                alignment: Alignment.centerLeft,
                Title: Terms!.cond4.toString()
            ),
          ],
        ),
      ),
    );
  }
}
