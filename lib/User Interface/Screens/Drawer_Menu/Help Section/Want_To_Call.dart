import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/ConstScreens/loadingScreen.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Other_Features/OpenDialer.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:flutter/material.dart';
import '../../../../API/Help_Section/Call-write_Us.dart';
import '../../../../Constant/assets.dart';
import '../../../../Models/HelpSection_Model/Call-Write_Model.dart';
import '../../../Constant Widgets/ConstScreens/NoData_Avl.dart';
import '../../../Constant Widgets/Other_Features/OpenEmail.dart';

class WantToCall extends StatefulWidget {
   const WantToCall({Key? key,}) : super(key: key);

  @override
  State<WantToCall> createState() => _WantToCallState();
}

class _WantToCallState extends State<WantToCall> {
  var selectedOption;
  var isSeleted;

  ContactUsModel? Contactdata;

  @override
  void initState() {
    fetchCallWriteUs().then((value){
      setState(() {
        Contactdata = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leadingWidth: 50,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 20,color: ColorConstant.whiteColor,),),
        title:  HeadingOne(
          Title: "Want to Call",
          fontSize: 25,
        ),
      ),
      body:Contactdata != null? CustomContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              HeadingOne(
                alignment: Alignment.center,
                fontSize: widths/20,
                textColor: ColorConstant.darkBlackColor,
                Title: "Once selected the trip details to open",
              ),
              const SizedBox(height: 10,),
              SubTitle_Text(
                Title: "Want to Call/ Write to Us.",
              ),
              const SizedBox(height: 20,),
              const Divider(),
              ExpansionTile(
                onExpansionChanged: (v){
                  OpenEmail.sendEmail(Contactdata!.data.email.toString());
                },
                trailing: const SizedBox(),
                leading: const Icon(Icons.email,),
                title: SubTitle_Text(
                  alignment: Alignment.centerLeft,
                  Title:Contactdata!.data.email.toString(),
                ),
              ),
              const Divider(),
              ExpansionTile(
                onExpansionChanged: (v){
                  OpenDailerPad.openDialPad(Contactdata!.data.phone1.toString());
                },
                trailing: const SizedBox(),
                leading: const Icon(Icons.call,),
                title: SubTitle_Text(
                  alignment: Alignment.centerLeft,
                  Title: "Call Us- ${Contactdata!.data.phone1.toString()}",
                ),
              ),
              const Divider(),
              Contactdata!.data.phone2.toString() != "null"?
              ExpansionTile(
                onExpansionChanged: (v){
                  OpenDailerPad.openDialPad(Contactdata!.data.phone2.toString());
                },
                trailing: const SizedBox(),
                leading: const Icon(Icons.call,),
                title: SubTitle_Text(
                  alignment: Alignment.centerLeft,
                  Title: "Call Us- ${Contactdata!.data.phone2.toString()}",
                ),
              ):Ink(),
              const Divider(),
            ],
          ),
        ),
      ):LoadingData(),
    );
  }
}

