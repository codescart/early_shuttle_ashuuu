class ExploreRoute {
  final int id;
  final String routeName;
  final int fare;
  final int mFare;
  final int wFare;
  final List<Stop> stops;
  final List<dynamic> timings;

  ExploreRoute({
    required this.id,
    required this.routeName,
    required this.fare,
    required this.mFare,
    required this.wFare,
    required this.stops,
    required this.timings,
  });

  factory ExploreRoute.fromJson(Map<String, dynamic> json) {
    List<dynamic> stopsData = json['stop'];
    List<Stop> stops = stopsData.map((stop) => Stop.fromJson(stop)).toList();

    return ExploreRoute(
      id: json['id'],
      routeName: json['route_name'],
      fare: json['fare'],
      mFare: json['mfare'],
      wFare: json['wfare'],
      stops: stops,
      timings: json['timings'],
    );
  }
}

class Stop {
  final int id;
  final String name;
  final String latitude;
  final String longitude;
  final int ordering;

  Stop({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.ordering,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      ordering: json['ordering'],
    );
  }
}
