class UserProfile {
  final int status;
  final String msg;
  final UserData data;

  UserProfile({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      status: json['status'],
      msg: json['msg'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String phone;
  final String email;
  final int verified;
  final String device;
  final int resetOtp;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? dob;
  final String? gender;
  final String? homeAddress;
  final String? officeAddress;
  final String? corporateEmail;
  final String? companyName;

  UserData({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.verified,
    required this.device,
    required this.resetOtp,
    required this.createdAt,
    required this.updatedAt,
    this.dob,
    this.gender,
    this.homeAddress,
    this.officeAddress,
    this.corporateEmail,
    this.companyName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      verified: json['verified'],
      device: json['device'],
      resetOtp: json['reset_otp'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      dob: json['dob'],
      gender: json['gender'],
      homeAddress: json['home_address'],
      officeAddress: json['office_address'],
      corporateEmail: json['corporate_email'],
      companyName: json['company_name'],
    );
  }
}
