import 'package:early_shuttle/API/Pass_Section/HistoryPass_Api.dart';
import 'package:early_shuttle/Constant/assets.dart';
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/My%20Pass/BuyPass.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/My%20Pass/MyPass_CurrentPage.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/My%20Pass/MyPass_History.dart';
import 'package:flutter/material.dart';

import '../../../../Constant/global_call.dart';

class MyPassScreen extends StatefulWidget {
  const MyPassScreen({Key? key}) : super(key: key);

  @override
  State<MyPassScreen> createState() => _MyPassScreenState();
}

class _MyPassScreenState extends State<MyPassScreen> {

  @override
  void initState() {
    callApi();
    super.initState();
  }
  callApi() async {
    final data = await fetchExpiredPassData();
    if(data != null){
      setState(() {
        GlobalCallClass.ViewPassHistoryData = data;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.primaryColor,
          leadingWidth: 50,
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios, size: 20,color: ColorConstant.whiteColor,),),
          title:  HeadingOne(
            Title: "My Pass",
            fontSize: 25,
          ),
          actions: [
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyPass()));
                },
                child: Image.asset(Graphics.cupon, scale: 7,)),
            SizedBox(width: 15,)
          ],
          bottom: TabBar(
            indicatorWeight: 1.3,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: ColorConstant.greyColor,
            tabs: [
              Tab(
                  child: TitleStyle(
                      Title:"Current Pass"
                  )
              ),
              Tab(
                  child:TitleStyle(
                    Title: "History",
                  )
              )
            ],
          ),
        ),

        body: TabBarView(
          children: <Widget>[
            CurrentPass(),
            PassHistory(),
          ],
        ),
      ),
    );
  }
}
