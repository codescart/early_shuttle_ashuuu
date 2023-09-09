import 'package:carousel_slider/carousel_slider.dart';
import 'package:early_shuttle/Models/HomePage_Sections/ImageSlider_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:flutter/material.dart';
import '../../../API/HomePage_Section/ImageSlider_Api.dart';
import '../../../Constant/color.dart';
import '../../Constant Widgets/Container/Container_widget.dart';
import '../../Constant Widgets/Other_Features/Launchweb.dart';
import '../../Constant Widgets/TextStyling/subtitleStyle.dart';


class HomePageImageSlider extends StatefulWidget {
  HomePageImageSlider({Key? key}) : super(key: key);

  @override
  State<HomePageImageSlider> createState() => _HomePageImageSliderState();
}

class _HomePageImageSliderState extends State<HomePageImageSlider> {

  @override
  void initState() {
    _fetchSliderData();
    super.initState();
  }

  ImageSlider? bannerData;

  Future<void> _fetchSliderData() async {
    try {
      final data = await fetchImageSliderData();
      setState(() {
        bannerData = data;
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return bannerData == null
        ? const SizedBox()
        : CarouselSlider(
            items: [
              bannerData!.data.surveytext != null && bannerData!.data.surveytext != null?
              InkWell(
                onTap: (){
                  OpenChrome.openUrl(bannerData!.data.surveylink);
                },
                child: CustomContainer(
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.only(left: 15, top: 0, bottom: 10),
                  alignment: Alignment.center,
                  color: ColorConstant.whiteColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TitleStyle(
                        textAlign: TextAlign.center,
                        alignment: Alignment.center,
                        textColor: ColorConstant.blueColor,
                        Title:"Survey\n click me to open survey form",
                      ),
                      SubTitle_Text(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        alignment: Alignment.center,
                        Title:bannerData!.data.surveytext,
                      ),
                      SubTitle_Text(
                        maxLines: 2,
                        alignment: Alignment.center,
                        Title:bannerData!.data.surveylink,
                      ),
                    ],
                  )
                ),
              )
                  : Image.network(bannerData!.data.homeBanner),
              Image.network(bannerData!.data.homeBanner),
              // Image.network(bannerData!.data.promotionBanner),
            ],
            options: CarouselOptions(
              height: 120.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 18 / 9,
              autoPlayCurve: Curves.easeInCubic,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              viewportFraction: 1.2,
            ),
          );
  }
}

