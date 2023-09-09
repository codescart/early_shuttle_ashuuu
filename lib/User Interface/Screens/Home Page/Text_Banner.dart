
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Constant/global_call.dart';
import 'package:early_shuttle/Models/HomePage_Sections/Text_Slider_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Home%20Page/HomePage.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class TextSlider_Banner extends StatefulWidget {
  final BannerResponse? bannerData;
  TextSlider_Banner({ this.bannerData});

  @override
  _TextSlider_BannerState createState() => _TextSlider_BannerState();
}

class _TextSlider_BannerState extends State<TextSlider_Banner> {

  @override
  void initState() {
    super.initState();
    // _fetchBannerData();
  }


  @override
  Widget build(BuildContext context) {
    return widget.bannerData == null
        ? const CircularProgressIndicator()
        : CustomContainer(
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
            alignment: Alignment.center,
            color: ColorConstant.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleStyle(
                  maxLines: 1,
                  alignment: Alignment.centerLeft,
                  textColor: Colors.black,
                  Title: widget.bannerData!.data.banner.title.toString(),
                ),
                SubTitle_Text(
                  maxLines: 2,
                  alignment: Alignment.centerLeft,
                  Title: widget.bannerData!.data.banner.text1.toString(),
                ),
                SubTitle_Text(
                  maxLines: 3,
                  alignment: Alignment.centerLeft,
                  Title: widget.bannerData!.data.banner.text2.toString(),
                )
              ],
            ),
          );
  }
}
