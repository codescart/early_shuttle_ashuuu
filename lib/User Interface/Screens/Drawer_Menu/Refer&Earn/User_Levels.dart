import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:flutter/material.dart';
import '../../../../Constant/assets.dart';
import '../../../Constant Widgets/TextStyling/smallTextStyle.dart';

class UserReferalLevel extends StatefulWidget {
  const UserReferalLevel({Key? key}) : super(key: key);

  @override
  State<UserReferalLevel> createState() => _UserReferalLevelState();
}

class _UserReferalLevelState extends State<UserReferalLevel> {
  List<levelContent> pages = [
    levelContent("1", Color(0xffddf0f6), ['Earm 25 Points once each referee complete verification', 'Earn 25 Points once each referee complete a ride', 'Earn 2% of your Referee\'s Ride Amount'], Graphics.level4),
    levelContent("2", Color(0xffffe6e6), ['Get 200 Rewards Points Bonus on reaching this level', 'Earn 25 points once each referee complete verification', 'Earn 30 Points once each referee complete a ride', 'Earn 2% Referee\'s Ride Amount'], Graphics.level3),
    levelContent("3", Color(0xfffcfcc5), ['Get 200 Rewards Points Bonus on reaching this level', 'Earn 25 points once each referee complete verification', 'Earn 30 Points once each referee complete a ride', 'Earn 2% Referee\'s Ride Amount'], Graphics.level1),
    levelContent("4", Color(0xffddf0f6), ['Get 200 Rewards Points Bonus on reaching this level', 'Earn 25 points once each referee complete verification', 'Earn 30 Points once each referee complete a ride', 'Earn 2% Referee\'s Ride Amount','Earn 30 Points once each referee complete a ride'], Graphics.level4),
    levelContent("5", Color(0xffddf0f6), ['Get 200 Rewards Points Bonus on reaching this level', 'Earn 25 points once each referee complete verification', 'Earn 30 Points once each referee complete a ride', 'Earn 2% Referee\'s '], Graphics.level4),
  ];
  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        leadingWidth: 50,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios, size: 20,color: ColorConstant.whiteColor,),),
        title:  HeadingOne(
          Title: "Referral Levels",
          fontSize: 25,
        ),
      ),
      body: CustomContainer(
        height: heights/1.2,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: PageView.builder(itemBuilder: (BuildContext, context){
          return CustomContainer(
            child: PageView.builder(
              scrollDirection: Axis.vertical,
                itemCount: pages.length,
                itemBuilder: (context, index){
              return CustomContainer(
                borderRadius:BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0,2),
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 2,
                      spreadRadius: 1
                  )
                ],
                margin: EdgeInsets.all(15),
                // height: heights,
                color:pages[index].bgColor,
                // width:widths,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    HeadingOne(
                      fontSize: 30,
                      textColor: ColorConstant.blueColor,
                      alignment: Alignment.center,
                      Title: "Level ${pages[index].Level}",),
                    Divider(),
                    Image.asset(pages[index].imagePath, ),
                    SizedBox(height: 15,),
                    HeadingOne(
                      alignment: Alignment.center,
                      textColor: ColorConstant.blueColor,
                      Title: "Benafits",
                    ),
                    SizedBox(height: 15,),
                    Column(
                      children: pages[index].benefits.map((benefit) {
                        return ListTile(
                          leading: Icon(Icons.star),
                          title: Small_Text(
                            alignment: Alignment.centerLeft,
                            Title:benefit ,
                          ),
                        );

                      }).toList(),
                    ),
                  ],
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

class levelContent{
  final String Level;
  final Color bgColor;
  final List<String> benefits;
  final String imagePath;

  levelContent(this.Level, this.bgColor, this.benefits, this.imagePath,);
}
