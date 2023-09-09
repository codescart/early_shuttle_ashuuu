class TermsOfUse {
  final int status;
  final String msg;
  final DataModel data;
  TermsOfUse({
    required this.status, required this.msg, required this.data
  });

  factory TermsOfUse.fromJson(Map<String, dynamic> json) {
    return TermsOfUse(
      status: json['status'],
      msg: json['msg'],
      data: DataModel.fromJson(json['data']),
    );
  }
}

class DataModel {
  final String url;

  DataModel({required this.url});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(url: json['url']);
  }
}