class LoginApiResponse {
  bool success;
  String message;
  User user;

  LoginApiResponse({
    required this.success,
    required this.message,
    required this.user,
  });

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) {
    return LoginApiResponse(
      success: json['success'],
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  int id;
  String? name;
  String phone;
  String? email;
  int verified;
  DateTime? otpTimestamp;
  DateTime createdAt;
  String otp;

  User({
    required this.id,
    this.name,
    required this.phone,
    this.email,
    required this.verified,
    this.otpTimestamp,
    required this.createdAt,
    required this.otp,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      verified: json['verified'],
      otpTimestamp: json['otp_timestamp'] != null
          ? DateTime.parse(json['otp_timestamp'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      otp: json['otp'],
    );
  }
}
