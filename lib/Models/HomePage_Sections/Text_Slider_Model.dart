
// class BannerModel {
//   final int id;
//   final String title;
//   final String text1;
//   final String text2;
//
//   BannerModel({
//     required this.id,
//     required this.title,
//     required this.text1,
//     required this.text2,
//   });
//
//   factory BannerModel.fromJson(Map<String, dynamic> json) {
//     return BannerModel(
//       id: json['id'],
//       title: json['title'],
//       text1: json['text1'],
//       text2: json['text2'],
//     );
//   }
// }


class BannerResponse {
  int status;
  String msg;
  BannerData data;

  BannerResponse({required this.status,required this.msg,required this.data});

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return BannerResponse(
      status: json['status'],
      msg: json['msg'],
      data: BannerData.fromJson(json['data']),
    );
  }
}

class BannerData {
  int status;
  String msg;
  Banner banner;
  int agreement;

  BannerData({required this.status,required this.msg,required this.banner,required this.agreement});

  factory BannerData.fromJson(Map<String, dynamic> json) {
    return BannerData(
      status: json['status'],
      msg: json['msg'],
      banner: Banner.fromJson(json['banner']),
      agreement: json['agreement'],
    );
  }
}

class Banner {
  int id;
  String title;
  String text1;
  String text2;
  String isActive;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Banner({
    required this.id,
    required this.title,
    required this.text1,
    required this.text2,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      title: json['title'],
      text1: json['text1'],
      text2: json['text2'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'],
    );
  }
}
