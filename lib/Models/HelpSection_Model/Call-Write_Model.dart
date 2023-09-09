class ContactUsModel {
  final int status;
  final String msg;
  final ContactInfoModel data;

  ContactUsModel({required this.status, required this.msg, required this.data});

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      status: json['status'],
      msg: json['msg'],
      data: ContactInfoModel.fromJson(json['data']),
    );
  }
}

class ContactInfoModel {
  final String email;
  final String phone1;
  final String phone2;

  ContactInfoModel({
    required this.email,
    required this.phone1,
    required this.phone2,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      email: json['email'],
      phone1: json['phone1'],
      phone2: json['phone2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone1': phone1,
      'phone2': phone2,
    };
  }
}