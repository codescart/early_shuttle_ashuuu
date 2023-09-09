class CurrentPassListModel {
  final int status;
  final String msg;
  final PassListData data;

  CurrentPassListModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory CurrentPassListModel.fromJson(Map<String, dynamic> json) {
    return CurrentPassListModel(
      status: json['status'],
      msg: json['msg'],
      data: PassListData.fromJson(json['data']),
    );
  }
}

class PassListData {
  final List<CurrentPass> passes;
  final List<dynamic> coupons;

  PassListData({
    required this.passes,
    required this.coupons,
  });

  factory PassListData.fromJson(Map<String, dynamic> json) {
    final passesList = json['passes'] as List<dynamic>;
    final List<CurrentPass> passes =
    passesList.map((e) => CurrentPass.fromJson(e)).toList();

    return PassListData(
      passes: passes,
      coupons: json['coupons'],
    );
  }
}

class CurrentPass {
  final int id;
  final int urouteId;
  final int drouteId;
  final int userId;
  final dynamic passType;
  final dynamic passPrice;
  final int validDays;
  final String expireOn;
  final int rides;
  final int avail;
  final int remaining;
  final int status;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final String routeName;

  CurrentPass({
    required this.id,
    required this.urouteId,
    required this.drouteId,
    required this.userId,
    required this.passType,
    required this.passPrice,
    required this.validDays,
    required this.expireOn,
    required this.rides,
    required this.avail,
    required this.remaining,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.routeName,
  });

  factory CurrentPass.fromJson(Map<String, dynamic> json) {
    return CurrentPass(
      id: json['id'],
      urouteId: json['uroute_id'],
      drouteId: json['droute_id'],
      userId: json['user_id'],
      passType: json['pass_type'],
      passPrice: json['pass_price'],
      validDays: json['valid_days'],
      expireOn: json['expire_on'],
      rides: json['rides'],
      avail: json['avail'],
      remaining: json['remaining'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      routeName: json['route_name'],
    );
  }
}
