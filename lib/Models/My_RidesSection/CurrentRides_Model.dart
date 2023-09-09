class CurrentRidesModel {
  final int status;
  final String msg;
  final List<CurrentRideItem> data;

  CurrentRidesModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory CurrentRidesModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['data'];
    List<CurrentRideItem> routeItems = dataList.map((item) => CurrentRideItem.fromJson(item)).toList();
    // List<CurrentRideItem> routeItems = dataList.map((item) {
    //   return CurrentRideItem.fromJson(item as Map<String, dynamic>);
    // }).toList();

    return CurrentRidesModel(
      status: json['status'] as int,
      msg: json['msg'] as String,
      data: routeItems,
    );
  }
}

class CurrentRideItem {
  final int id;
  final int userId;
  final String pickupDate;
  final String pickupTime;
  final int pickup;
  final int drop;
  final int busScheduleId;
  final int monthPass;
  final String device;
  final dynamic fare;
  final int otp;
  final int verified;
  final int cancelled;
  final String createdAt;
  final String updatedAt;
  final dynamic creditExpDate;
  final int cancelledNumber;
  final String driverName;
  final String driverNumber;
  final String busNumber;
  final String pickupName;
  final String dropName;
  final int passId;
  final String payType;
  final int busId;
  final int routeId;
  final String gpsDeviceId;
  final dynamic expireOn;
  final String paidBy;

  CurrentRideItem({
    required this.id,
    required this.userId,
    required this.pickupDate,
    required this.pickupTime,
    required this.pickup,
    required this.drop,
    required this.busScheduleId,
    required this.monthPass,
    required this.device,
    required this.fare,
    required this.otp,
    required this.verified,
    required this.cancelled,
    required this.createdAt,
    required this.updatedAt,
    required this.creditExpDate,
    required this.cancelledNumber,
    required this.driverName,
    required this.driverNumber,
    required this.busNumber,
    required this.pickupName,
    required this.dropName,
    required this.passId,
    required this.payType,
    required this.busId,
    required this.routeId,
    required this.gpsDeviceId,
    required this.expireOn,
    required this.paidBy,
  });

  factory CurrentRideItem.fromJson(Map<String, dynamic> json) {
    return CurrentRideItem(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      pickupDate: json['pickup_date'] as String,
      pickupTime: json['pickup_time'] as String,
      pickup: json['pickup'] as int,
      drop: json['drop'] as int,
      busScheduleId: json['bus_shedule_id'] as int,
      monthPass: json['month_pass'] as int,
      device: json['device'] as String,
      fare: json['fare'] as int,
      otp: json['otp'] as int,
      verified: json['verified'] as int,
      cancelled: json['cancelled'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      creditExpDate: json['credit_exp_dt'],
      cancelledNumber: json['cancelled_number'] as int,
      driverName: json['driver_name'] as String,
      driverNumber: json['driver_number'] as String,
      busNumber: json['bus_number'] as String,
      pickupName: json['pickup_name'] as String,
      dropName: json['drop_name'] as String,
      passId: json['pass_id'] as int,
      payType: json['pay_type'] as String,
      busId: json['bus_id'] as int,
      routeId: json['route_id'] as int,
      gpsDeviceId: json['gps_deviceid'] as String,
      expireOn: json['expire_on'],
      paidBy: json['paid_by'] as String,
    );
  }
}
