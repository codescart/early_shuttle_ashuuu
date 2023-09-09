// class PurchasePassModel {
//   final int success;
//   final String msg;
//   final List<PurchasePassRoutes> data;
//
//   PurchasePassModel({
//     required this.success,
//     required this.msg,
//     required this.data,
//   });
//
//   factory PurchasePassModel.fromJson(Map<String, dynamic> json) {
//     final List<dynamic> dataList = json['data'];
//     final List<PurchasePassRoutes> routeDataList =
//     dataList.map((e) => PurchasePassRoutes.fromJson(e)).toList();
//
//     return PurchasePassModel(
//       success: json['success'],
//       msg: json['msg'],
//       data: routeDataList,
//     );
//   }
// }
//
// class PurchasePassRoutes {
//   final dynamic urouteId;
//   final dynamic drouteId;
//   final dynamic urouteName;
//   final dynamic drouteName;
//   final dynamic fare;
//   final dynamic mfare;
//   final dynamic wfare;
//   final dynamic sfare;
//   final dynamic srides;
//   final dynamic svalidity;
//   final dynamic smsg;
//
//   PurchasePassRoutes({
//     required this.urouteId,
//     required this.drouteId,
//     required this.urouteName,
//     required this.drouteName,
//     required this.fare,
//     required this.mfare,
//     required this.wfare,
//     required this.sfare,
//     required this.srides,
//     required this.svalidity,
//     required this.smsg,
//   });
//
//   factory PurchasePassRoutes.fromJson(Map<String, dynamic> json) {
//     return PurchasePassRoutes(
//       urouteId: json['uroute_id'],
//       drouteId: json['droute_id'],
//       urouteName: json['uroute_name'],
//       drouteName: json['droute_name'],
//       fare: json['fare'].toDouble(),
//       mfare: json['mfare'].toDouble(),
//       wfare: json['wfare'].toDouble(),
//       sfare: json['sfare'].toDouble(),
//       srides: json['srides'],
//       svalidity: json['svalidity'],
//       smsg: json['smsg'],
//     );
//   }
// }

class RouteFare {
  final int urouteId;
  final int drouteId;
  final String urouteName;
  final String? drouteName;
  final String distance;
  final String routeType;
  final String eta;
  final String companyName;
  final int routeFareId;
  final String fareType;
  final int fare;
  final int validDays;
  final int rides;

  RouteFare({
    required this.urouteId,
    required this.drouteId,
    required this.urouteName,
    required this.drouteName,
    required this.distance,
    required this.routeType,
    required this.eta,
    required this.companyName,
    required this.routeFareId,
    required this.fareType,
    required this.fare,
    required this.validDays,
    required this.rides,
  });

  factory RouteFare.fromJson(Map<String, dynamic> json) {
    return RouteFare(
      urouteId: json['uroute_id'],
      drouteId: json['droute_id'],
      urouteName: json['uroute_name'],
      drouteName: json['droute_name'],
      distance: json['distance'],
      routeType: json['route_type'],
      eta: json['eta'],
      companyName: json['company_name'],
      routeFareId: json['route_fare_id'],
      fareType: json['fare_type'],
      fare: json['fare'],
      validDays: json['valid_days'],
      rides: json['rides'],
    );
  }
}

class RouteKey {
  final int urouteId;
  final int drouteId;
  final String urouteName;
  final String? drouteName;
  final String distance;
  final String routeType;
  final String eta;
  final String companyName;

  RouteKey({
    required this.urouteId,
    required this.drouteId,
    required this.urouteName,
    required this.drouteName,
    required this.distance,
    required this.routeType,
    required this.eta,
    required this.companyName,
  });

  factory RouteKey.fromJson(Map<String, dynamic> json) {
    return RouteKey(
      urouteId: json['uroute_id'],
      drouteId: json['droute_id'],
      urouteName: json['uroute_name'],
      drouteName: json['droute_name'],
      distance: json['distance'],
      routeType: json['route_type'],
      eta: json['eta'],
      companyName: json['company_name'],
    );
  }
}

class RouteResponse {
  final RouteKey routeKey;
  final List<RouteFare> routes;

  RouteResponse({
    required this.routeKey,
    required this.routes,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    final routeKey = RouteKey.fromJson(json['route_key']);
    final routes = List<RouteFare>.from(
      json['routes'].map((route) => RouteFare.fromJson(route)),
    );

    return RouteResponse(
      routeKey: routeKey,
      routes: routes,
    );
  }
}





