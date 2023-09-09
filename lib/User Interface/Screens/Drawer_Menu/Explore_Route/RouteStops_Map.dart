// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:early_shuttle/Models/HelpSection_Model/TripRelated_Model.dart';
import 'package:early_shuttle/Testing/test2.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
import 'package:early_shuttle/User%20Interface/Screens/Drawer_Menu/Help%20Section/Suggest_new_time_slot_popup.dart';
import 'package:early_shuttle/User%20Interface/Screens/SelectRoute/Selecet_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'dart:convert';
import 'dart:math';
import '../../../../Constant/assets.dart';
import '../../../../Constant/color.dart';
import '../../../../Models/Explore_Route/ExploreRoute_Model.dart';
import '../../../../Utils/message_utils.dart';
import '../../../../main.dart';
import '../../../Constant Widgets/Buttons/PrimaryButton.dart';
import '../../../Constant Widgets/ConstScreens/loadingScreen.dart';
import '../../../Constant Widgets/Container/Container_widget.dart';
import '../../../Constant Widgets/TextStyling/AppBarTitle.dart';
import '../../../Constant Widgets/TextStyling/subtitleStyle.dart';

class RouteDetailsPage extends StatefulWidget {
  final ExploreRoute route;
  final HelpDetail? selectedTicketData;

  const RouteDetailsPage({
    super.key,
    required this.route,
    this.selectedTicketData,
  });

  @override
  _RouteDetailsPageState createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  List<LatLng> _routeCoordinates = [];
  LocationData? currentLocation;
  Location location = Location();
  Stop? selectedSourseStopDetails;

  List<Stop>? _stopsSelectedForBooking = [];

  bool isLoaded = false;
  bool isPolylineCreated = false;

  @override
  void initState() {
    super.initState();
    _getLocation();
    _createRouteCoordinates();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
    try {
      var userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void _createRouteCoordinates() async {
    List<LatLng> coordinates = [];
    for (int i = 0; i < widget.route.stops.length; i++) {
      double lat = double.parse(widget.route.stops[i].latitude);
      double lng = double.parse(widget.route.stops[i].longitude);
      coordinates.add(LatLng(lat, lng));

      final BitmapDescriptor deviceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(25, 25)),
        Graphics.allstops, // Replace with your image path.
      );

      _markers.add(Marker(
          markerId: MarkerId(widget.route.stops[i].id.toString()),
          position: LatLng(lat, lng),
          icon: deviceIcon,
          infoWindow: InfoWindow(
            title: widget.route.stops[i].name,
          ),
          onTap: () {
            if (_stopsSelectedForBooking!.length < 2) {
              setState(() {
                _stopsSelectedForBooking!.add(widget.route.stops[i]);
                selectedSourseStopDetails = widget.route.stops[i];
              });
            } else {
              print("max two address allowed");
            }
          }));
    }

    _routeCoordinates = coordinates;
    if (_routeCoordinates.length >= 2) {
      await _fetchAndDrawPolyline();
      _getNearestStop();
    }
  }

  Future<void> _fetchAndDrawPolyline() async {
    List<LatLng> polylineCoordinates = [];

    for (int i = 0; i < _routeCoordinates.length - 1; i++) {
      final start = _routeCoordinates[i];
      final end = _routeCoordinates[i + 1];

      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&mode=driving&key=AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> routes = data['routes'];
        if (routes.isNotEmpty) {
          final List<dynamic> legs = routes[0]['legs'];
          if (legs.isNotEmpty) {
            final List<dynamic> steps = legs[0]['steps'];
            if (steps.isNotEmpty) {
              for (int j = 0; j < steps.length; j++) {
                final List<dynamic> points =
                    decodePolyline(steps[j]['polyline']['points']);
                if (points.isNotEmpty) {
                  polylineCoordinates.addAll(points as Iterable<LatLng>);
                }
              }
            }
          }
        }
      }
    }

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          color: Colors.red,
          points: polylineCoordinates,
          width: 5,
        ),
      );
      isPolylineCreated = true;
    });
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    double lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }

  final Set<Polyline> _polylines = {};

  Future<void> _fetchAndDrawPolylinefrom(LatLng originLatLng,
      LatLng destinationLatLng, String polylineId, Color color) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${originLatLng.latitude},${originLatLng.longitude}&destination=${destinationLatLng.latitude},${destinationLatLng.longitude}&mode=driving&key=AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> routes = data['routes'];
      if (routes.isNotEmpty) {
        final List<dynamic> legs = routes[0]['legs'];
        if (legs.isNotEmpty) {
          final List<dynamic> steps = legs[0]['steps'];
          if (steps.isNotEmpty) {
            List<LatLng> polylineCoordinates = [];
            for (int j = 0; j < steps.length; j++) {
              final List<dynamic> points =
                  decodePolyline(steps[j]['polyline']['points']);
              if (points.isNotEmpty) {
                polylineCoordinates.addAll(points as Iterable<LatLng>);
              }
            }
            setState(() {
              _polylines.add(
                Polyline(
                  polylineId: PolylineId(polylineId),
                  color: color,
                  points: polylineCoordinates,
                  width: 5,
                  patterns: [PatternItem.dot, PatternItem.gap(5)],
                ),
              );
            });
          }
        }
      }
    }
  }

  Future<void> _getNearestStop() async {
    if (currentLocation == null) {
      return;
    }

    double currentLat = currentLocation!.latitude!;
    double currentLng = currentLocation!.longitude!;

    LatLng nearestStopLatLng = const LatLng(0, 0); // Initial value
    double nearestDistance = double.infinity; // Initial value

    for (final stop in widget.route.stops) {
      double stopLat = double.parse(stop.latitude);
      double stopLng = double.parse(stop.longitude);
      double distance =
          _calculateDistance(currentLat, currentLng, stopLat, stopLng);

      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearestStopLatLng = LatLng(stopLat, stopLng);
      }
    }
    await _fetchAndDrawPolylinefrom(
      LatLng(currentLat, currentLng),
      nearestStopLatLng,
      "current_to_nearest",
      Colors.purpleAccent,
    );

    setState(() {
      _nearestStopMarker = null;
      _currentLocationMarker = null;
      _nearestStopMarker = Marker(
        markerId: const MarkerId('nearest_stop'),
        position: nearestStopLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(
          title: 'Nearest Stop',
        ),
      );

      _currentLocationMarker = Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(currentLat, currentLng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(
          title: 'Your Location',
        ),
      );

      // Set the camera position to your current location
      _cameraPosition = CameraPosition(
        target: LatLng(currentLat, currentLng),
        zoom: 12.0,
      );
    });

    // Move the camera to your current location
    // if (_controller != null) {
    //   _controller
    //       .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition!));
    // }
  }

  Marker? _nearestStopMarker;
  Marker? _currentLocationMarker;
  CameraPosition? _cameraPosition; // Add this variable

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  Polyline? _currentToNearestPolyline;

  TimeOfDay _selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SuggestNewTimeSlotPopUp(
                  selectedStopData: selectedSourseStopDetails,
                  selectedTime: _selectedTime,
              selectedHelpDetails:widget.selectedTicketData!
              );
            });
      });
    }
  }

  void clearList() {
    setState(() {
      _stopsSelectedForBooking = []; // Reassign an empty list
      // selectedIndex = null; // Clear the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded == false
        ? const LoadingData()
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: ColorConstant.whiteColor,
                ),
              ),
              backgroundColor: ColorConstant.primaryColor,
              title: HeadingOne(
                  textAlign: TextAlign.left,
                  alignment: Alignment.centerLeft,
                  Title: " ${widget.route.routeName}"),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>testingPassFilter(
                      uroute:_stopsSelectedForBooking!,

                    )));
                  },
                  child: Image.asset(
                    Graphics.cupon,
                    width: 35,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                isPolylineCreated == false
                    ? SizedBox()
                    : Tooltip(
                        message: "Get your nearest stop",
                        child: PrimaryButton(
                          onTap: () {
                            // _getNearestStop();
                            _controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    _cameraPosition!));
                          },
                          color: Colors.transparent,
                          width: width / 8,
                          icon: Icons.location_history,
                          iconSize: width / 12,
                        ),
                      )
              ],
            ), //isPolylineCreated
            body: isPolylineCreated == true
                ? GoogleMap(
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      setState(() {
                        _controller = controller;
                        _createRouteCoordinates(); // Call this function after the map is created.
                      });
                    },
                    initialCameraPosition: _cameraPosition != null
                        ? _cameraPosition! // Use the camera position if it's set
                        : CameraPosition(
                            target: _routeCoordinates.isNotEmpty
                                ? _routeCoordinates.first
                                : const LatLng(0, 0),
                            zoom: 12.0,
                          ),
                    markers: _markers.toSet()
                      ..addAll(_nearestStopMarker != null
                          ? [_nearestStopMarker!]
                          : [])
                      ..addAll(_currentLocationMarker != null
                          ? [_currentLocationMarker!]
                          : []),
                    polylines: _polylines.toSet()
                      ..addAll(_currentToNearestPolyline != null
                          ? [_currentToNearestPolyline!]
                          : []),
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      GoogleMap(
                        zoomControlsEnabled: false,
                        onMapCreated: (controller) {
                          setState(() {
                            _controller = controller;
                            _createRouteCoordinates(); // Call this function after the map is created.
                          });
                        },
                        initialCameraPosition: _cameraPosition != null
                            ? _cameraPosition! // Use the camera position if it's set
                            : CameraPosition(
                                target: _routeCoordinates.isNotEmpty
                                    ? _routeCoordinates.first
                                    : const LatLng(0, 0),
                                zoom: 12.0,
                              ),
                        markers: _markers.toSet()
                          ..addAll(_nearestStopMarker != null
                              ? [_nearestStopMarker!]
                              : [])
                          ..addAll(_currentLocationMarker != null
                              ? [_currentLocationMarker!]
                              : []),
                        polylines: _polylines.toSet()
                          ..addAll(_currentToNearestPolyline != null
                              ? [_currentToNearestPolyline!]
                              : []),
                      ),
                      CustomContainer(
                        height: height,
                        width: width,
                        color: ColorConstant.darkBlackColor.withOpacity(0.5),
                        alignment: FractionalOffset.center,
                        child: CustomContainer(
                          width: width/4.5,
                          height: width/4.5,
                          padding: EdgeInsets.all(20),
                          border: Border.all(width: 1, color: ColorConstant.darkBlackColor),
                          color: ColorConstant.whiteColor.withOpacity(0.9),
                          child: CircularProgressIndicator(color: ColorConstant.blueColor,),
                        )
                      )

                    ],
                  ),
            bottomSheet: isPolylineCreated == false?
                CustomContainer(
                  color: ColorConstant.whiteColor,
                    padding: EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 10),
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TitleStyle(
                        textColor: ColorConstant.blueColor,
                        Title: "Please wait data is loading ",
                      ),
                    ],
                  )
                ):
            _stopsSelectedForBooking!.isEmpty
                ? CustomContainer(
                    color: ColorConstant.whiteColor,
                    // height: height / 15,
                    padding: EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.route != null &&
                            widget.selectedTicketData == null)
                          SubTitle_Text(
                            textAlign: TextAlign.center,
                            textColor: ColorConstant.blueColor,
                            Title:
                                "Select source and destination stops to proceed booking",
                          ),
                        if (widget.route != null &&
                            widget.selectedTicketData != null)
                          SubTitle_Text(
                            textAlign: TextAlign.center,
                            textColor: ColorConstant.darkBlackColor,
                            Title: "Select stop to proceed",
                          ),
                      ],
                    ))
                : CustomContainer(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    border:
                        Border.all(color: ColorConstant.greyColor, width: 1),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: ColorConstant.whiteColor,
                    child:
                        widget.route != null &&
                                widget.selectedTicketData == null
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: List.generate(
                                        _stopsSelectedForBooking!.length,
                                        (index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SubTitle_Text(
                                                alignment: Alignment.centerLeft,
                                                textAlign: TextAlign.left,
                                                textColor: ColorConstant
                                                    .darkBlackColor,
                                                Title: _stopsSelectedForBooking!
                                                        .isEmpty
                                                    ? ""
                                                    : index == 0
                                                        ? "Source Stop"
                                                        : "Destination Stop",
                                                fontWeight: FontWeight.bold,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    // _stopsSelectedForBooking!.clear();
                                                    _stopsSelectedForBooking!
                                                        .removeAt(index);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.cancel_outlined,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                          SubTitle_Text(
                                            alignment: Alignment.centerLeft,
                                            textAlign: TextAlign.left,
                                            // width: width / 1.8,
                                            textColor:
                                                ColorConstant.darkBlackColor,
                                            Title:
                                                _stopsSelectedForBooking![index]
                                                    .name,
                                          ),
                                          Divider(),
                                        ],
                                      );
                                    }),
                                  ),
                                  if (_stopsSelectedForBooking!.length < 2)
                                    SubTitle_Text(
                                      Title: "Select destination stop",
                                    ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (widget.route != null &&
                                      widget.selectedTicketData == null)
                                    PrimaryButton(
                                      onTap: () {
                                        if(_stopsSelectedForBooking!.length==2){
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                  ColorConstant.whiteColor,
                                                  title: TitleStyle(
                                                    textAlign: TextAlign.center,
                                                    textColor: ColorConstant
                                                        .darkBlackColor,
                                                    Title:
                                                    "Please choose a schedule for the bus.",
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        PrimaryButton(
                                                          onTap: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Select_route(
                                                                      fromLatitude:
                                                                      _stopsSelectedForBooking![0]
                                                                          .latitude,
                                                                      fromLongitude:
                                                                      _stopsSelectedForBooking![0]
                                                                          .longitude,
                                                                      toLatitude:
                                                                      _stopsSelectedForBooking![1]
                                                                          .latitude,
                                                                      toLongitude:
                                                                      _stopsSelectedForBooking![1]
                                                                          .longitude,
                                                                      routeType:
                                                                      "morning")),
                                                            );
                                                          },
                                                          width: width / 4,
                                                          Label: "Morning",
                                                        ),
                                                        PrimaryButton(
                                                          color: ColorConstant.blueColor,
                                                          onTap: () {
                                                            Navigator.of(context)
                                                                .pop();
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Select_route(
                                                                      fromLatitude:
                                                                      _stopsSelectedForBooking![0]
                                                                          .latitude,
                                                                      fromLongitude:
                                                                      _stopsSelectedForBooking![0]
                                                                          .longitude,
                                                                      toLatitude:
                                                                      _stopsSelectedForBooking![1]
                                                                          .latitude,
                                                                      toLongitude:
                                                                      _stopsSelectedForBooking![1]
                                                                          .longitude,
                                                                      routeType:
                                                                      "evening")),
                                                            );
                                                          },
                                                          width: width / 4,
                                                          Label: "Evening",
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              });
                                        }
                                        else{
                                          Utils.flushBarErrorMessage("Both source and destination is required to proceed", context);
                                        }
                                      },
                                      Label: "Proceed to ticket booking",
                                    ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  // if (widget.route != null &&
                                  //     widget.selectedTicketData != null)
                                  //   PrimaryButton(
                                  //     onTap: () {
                                  //       _selectTime(context);
                                  //     },
                                  //     Label: widget.selectedTicketData!
                                  //         .tktTypeDetailDescription,
                                  //   ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SubTitle_Text(
                                        alignment: Alignment.centerLeft,
                                        textAlign: TextAlign.left,
                                        textColor: ColorConstant.darkBlackColor,
                                        Title: selectedSourseStopDetails == null
                                            ? ""
                                            : "Selected Stop-  ",
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SubTitle_Text(
                                        alignment: Alignment.centerLeft,
                                        textAlign: TextAlign.left,
                                        width: width / 1.8,
                                        textColor: ColorConstant.darkBlackColor,
                                        Title: selectedSourseStopDetails == null
                                            ? ""
                                            : selectedSourseStopDetails!.name,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (widget.route != null &&
                                      widget.selectedTicketData != null)
                                    PrimaryButton(
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                      Label: widget.selectedTicketData!
                                          .tktTypeDetailDescription,
                                    ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                  ),
          );
  }

  Future SuggestionTimeSlot() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            child: CustomContainer(
              color: ColorConstant.whiteColor,
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TitleStyle(
                    textColor: ColorConstant.darkBlackColor,
                    Title: "Are you sure want to submit the selected details",
                  ),
                  SubTitle_Text(
                    Title: "Stop name",
                  ),
                  SubTitle_Text(
                    Title: selectedSourseStopDetails!.name,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
