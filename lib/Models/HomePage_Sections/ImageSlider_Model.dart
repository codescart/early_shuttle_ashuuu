// class ImageSlider {
//   final String promotionBanner;
//   final String homeBanner;
//
//   ImageSlider({required this.promotionBanner, required this.homeBanner});
//
//   factory ImageSlider.fromJson(Map<String, dynamic> json) {
//     return ImageSlider(
//       promotionBanner: json['promotion_banner'],
//       homeBanner: json['home_banner'],
//     );
//   }
// }

class ImageSlider {
  int status;
  String msg;
  Data data;

  ImageSlider({required this.status,required this.msg,required this.data});

  factory ImageSlider.fromJson(Map<String, dynamic> json) {
    return ImageSlider(
      status: json['status'],
      msg: json['msg'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  String promotionBanner;
  String homeBanner;
  String surveytext;
  String surveylink;

  Data({required this.promotionBanner,required this.homeBanner,required this.surveytext,required this.surveylink});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      promotionBanner: json['promotion_banner'],
      homeBanner: json['home_banner'],
      surveytext: json['survey_text'],
      surveylink: json['survey_link'],
    );
  }
}
