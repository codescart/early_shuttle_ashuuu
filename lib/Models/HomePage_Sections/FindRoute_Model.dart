class RouteData {
  final int status;
  final String msg;
  final List<RouteInfo> data;

  RouteData({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory RouteData.fromJson(Map<String, dynamic> json) {
    List<RouteInfo> routeList = [];
    if (json['data'] != null) {
      // routeData = jsonData.map((data) => RouteInfo.fromJson(data)).toList();
      routeList = List<RouteInfo>.from(
          json['data'].map((routeJson) => RouteInfo.fromJson(routeJson)));
    }

    return RouteData(
      status: json['status'],
      msg: json['msg'],
      data: routeList,
    );
  }
}

class RouteInfo {
  final int pickupStop;
  final String pickupStopName;
  final double pickupLat;
  final double pickupLng;
  final int pickupOrder;
  final int routeId;
  final double distance;
  final double distance2;
  final String routeName;
  final int fare;
  final String hasPass;
  final String passId;
  final int dropStop;
  final String dropStopName;
  final double dropLat;
  final double dropLng;
  final int dropOrder;

  RouteInfo({
    required this.pickupStop,
    required this.pickupStopName,
    required this.pickupLat,
    required this.pickupLng,
    required this.pickupOrder,
    required this.routeId,
    required this.distance,
    required this.distance2,
    required this.routeName,
    required this.fare,
    required this.hasPass,
    required this.passId,
    required this.dropStop,
    required this.dropStopName,
    required this.dropLat,
    required this.dropLng,
    required this.dropOrder,
  });

  factory RouteInfo.fromJson(Map<String, dynamic> json) {
    return RouteInfo(
      pickupStop: json['pickup_stop'],
      pickupStopName: json['pickup_stop_name'],
      pickupLat: double.parse(json['pickup_lat']),
      pickupLng: double.parse(json['pickup_lng']),
      pickupOrder: json['pickup_order'],
      routeId: json['route_id'],
      distance: json['distance'],
      distance2: json['distance2'],
      routeName: json['route_name'],
      fare: json['fare'],
      hasPass: json['hasPass'],
      passId: json['passid'],
      dropStop: json['drop_stop'],
      dropStopName: json['drop_stop_name'],
      dropLat: double.parse(json['drop_lat']),
      dropLng: double.parse(json['drop_lng']),
      dropOrder: json['drop_order'],
    );
  }
}
