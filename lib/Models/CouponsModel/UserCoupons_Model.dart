class CouponResponse {
  final int status;
  final String msg;
  final List<CouponInfo> data;

  CouponResponse({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonData = json['data'];
    List<CouponInfo> couponData = [];

    for (var item in jsonData) {
      couponData.add(CouponInfo.fromJson(item));
    }

    return CouponResponse(
      status: json['status'],
      msg: json['msg'],
      data: couponData,
    );
  }
}

class CouponInfo {
  final int id;
  final String title;
  final String subtitle;
  final int userId;
  final DateTime startDate;
  final DateTime expiryDate;
  final int discount;
  final int amountRemaining;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt; // Nullable field
  final String passType;
  final int urouteId;
  final int drouteId;
  final int staffId;

  CouponInfo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.userId,
    required this.startDate,
    required this.expiryDate,
    required this.discount,
    required this.amountRemaining,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.passType,
    required this.urouteId,
    required this.drouteId,
    required this.staffId,
  });

  factory CouponInfo.fromJson(Map<String, dynamic> json) {
    return CouponInfo(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      userId: json['user_id'],
      startDate: DateTime.parse(json['start_date']),
      expiryDate: DateTime.parse(json['expiry_date']),
      discount: json['discount'],
      amountRemaining: json['amount_remaining'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'],
      passType: json['pass_type'],
      urouteId: json['uroute_id'],
      drouteId: json['droute_id'],
      staffId: json['staff_id'],
    );
  }
}
