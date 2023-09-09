import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:early_shuttle/Constant/color.dart';
import 'package:early_shuttle/Models/HelpSection_Model/TripRelated_Model.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Buttons/PrimaryButton.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Text%20Field/TextField_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../Constant/assets.dart';
import '../../../../main.dart';

class testmaplocation extends StatefulWidget {
  // final String locationType;
  final HelpDetail? selectedTicketData;
  const testmaplocation({
    Key? key,
    this.selectedTicketData,
  }) : super(key: key);

  @override
  State<testmaplocation> createState() => _testmaplocationState();
}

class _testmaplocationState extends State<testmaplocation> {
  String radius = "30";

  double latitude = 31.5111093;
  double longitude = 74.279664;
  var lat = "0.000";
  var long = "0.000";
  var latt;
  var longg;

  Completer<GoogleMapController> _controller = Completer();
  String _draggedAddress = "";
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  _init() {
    _defaultLatLng = const LatLng(20.5937, 78.9629);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(target: _defaultLatLng, zoom: 10.5);
    _gotoUserCurrentPosition();
  }

  Uint8List? marketimages;
  final List<Marker> _markers = [];
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List?> loadNetWorkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;
    final byteData =
    await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  var totallen;
  Widget _getMap() {
    return GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_markers),
        initialCameraPosition: _cameraPosition!,
        mapType: MapType.terrain,
        onCameraIdle: () {
          _getAddress(_draggedLatlng);
        },
        onCameraMove: (cameraPosition) {
          _draggedLatlng = cameraPosition.target;
        },
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          }
        });
  }

  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
    final Uint8List locationIcon = await getImages('assets/googleicon.png', 70);
    setState(() async {
      lat = currentPosition.latitude.toString();
      long = currentPosition.longitude.toString();
      var lats = double.parse(lat);
      var longs = double.parse(long);
      _markers.add(Marker(
        markerId: MarkerId('0'),
        icon: BitmapDescriptor.fromBytes(locationIcon),
        position: LatLng(lats, longs),
        infoWindow: InfoWindow(
          title: "userName",
        ),
        draggable: true,
        onDragEnd: ((newPosition) {
          print('rrrrrrrrrrrr');
          print(newPosition.latitude);
          print(newPosition.longitude);
        }),
      ));
    });
  }

  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 13.5)));
    await _getAddress(position);
  }

  Future _getAddress(LatLng position) async {
    _suggestions.clear();
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addresStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    setState(() {
      latt = position.latitude;
      longg = position.longitude;
      _draggedAddress = addresStr;
    });
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

// fetch live location from the map
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _suggestions = [];

  Future<void> _getSuggestions(String input) async {
    const apiKey =
        'AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM'; // Replace with your API key
    final endpoint = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey',
    );

    final response = await http.get(endpoint);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      print("data");
      final predictions = data['predictions'];
      if (kDebugMode) {
        print("saaaaaaaaaaaaaaaaaa");
      }
      if (kDebugMode) {
        print(predictions);
      }
      setState(() {
        _suggestions = predictions.map((prediction) {
          final description = prediction['description'] as String;
          final placeId = prediction['place_id'] as String;
          return {'description': description, 'place_id': placeId};
        }).toList();
      });
    }
  }

  Future<Map<String, double>> getLatLngFromPlaceId(
      String placeId, String address) async {
    const apiKey = 'AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM';
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey'));
    final decodedResponse = json.decode(response.body);
    print(decodedResponse);
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      if (decodedResponse['status'] == 'OK') {
        final location = decodedResponse['result']['geometry']['location'];
        searchedLocationLatitude = location['lat'];
        searchedLocationLongitude = location['lng'];
        if (searchedLocationLongitude != null &&
            searchedLocationLatitude != null) {
          print("aaaaaaaaaaaaaa");
          print(address);
          print(searchedLocationLatitude);
          print(searchedLocationLongitude);
          _suggestions.clear();
          final searchlatlan = LatLng(searchedLocationLatitude, searchedLocationLongitude);
          // showDialog(context: context, builder: (BuildContext, context))
          // Navigator.pop(
          //   context,
          //   {
          //     'locationName': address,
          //     'latitude': searchedLocationLatitude,
          //     'longitude': searchedLocationLongitude,
          //   },
          // );
          _gotoSpecificPosition(searchlatlan);

        }

        return {
          'latitude': searchedLocationLatitude,
          'longitude': searchedLocationLongitude
        };
      } else {
        throw Exception(
            'Failed to fetch location details: ${decodedResponse['error_message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch location details: ${response.statusCode}');
    }
  }

  Widget _getLoctionButton() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: InkWell(
        onTap: () {
          _gotoUserCurrentPosition();
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8.0),
            // border: Border.all(
            //   width: 1.2, color: Colors.black
            // ),
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
            ],
          ),
          child: Icon(Icons.my_location),
        ),
      ),
    );
  }

  Widget _getCustomPin() {
    return Positioned(
      top: height / 2.8,
      left: width / 2.3,
      child: InkWell(
        onTap: () async {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                title: Text(
                  _draggedAddress,
                ),
                content: Container(
                  height: 200,
                  width: 400,
                  child: Column(
                    children: [
                      Text(
                        'Latitude ' + latt.toString(),
                      ),
                      Text(
                        'longitude ' + longg.toString(),
                      ),
                      Text(
                        'Adress ' + _draggedAddress,
                      ),
                    ],
                  ),
                  // child:Alerts(
                  //     lats:latt.toString(),
                  //     longs:longg.toString(),
                  //     address:_draggedAddress
                  // )
                )),
          );
        },
        child: Container(
          width: 50,
          height: 50,
          child: Image.asset(Graphics.bluePin),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(children: [
      _getMap(),
      _getCustomPin(),
      _getLoctionButton(),
      _suggestions.isNotEmpty
          ? Container(
        color: Colors.white,
        height: height / 3,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _suggestions.length,
          itemBuilder: (context, index) {
            location = _suggestions[index]['description'];
            final placeId = _suggestions[index]['place_id'];
            print(placeId);
            return ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: const Icon(Icons.location_on_outlined),
              title: Text(
                location.toString(),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                getLatLngFromPlaceId(placeId, location.toString());
                print('aaaaaaaaaaaaaaa');
                // print(latt.toString()+long.toString()+_draggedAddress);
              },
            );
          },
        ),
      )
          : SizedBox(),
    ]);
  }
  String SearchAddress="";

  String? location;
  var liveLocation;
  var searchedLocationLatitude;
  var searchedLocationLongitude;

  void initState() {
    // DateTime selectedDate = DateTime.now();
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorConstant.primaryColor,
          automaticallyImplyLeading: false,
          leading: IconButton(onPressed: () {
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios, color: ColorConstant.whiteColor,),),
          iconTheme: IconThemeData(color: Colors.black),
          title: HeadingOne(
            Title: "Choose your Location",
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: CustomContainer(
              color: ColorConstant.whiteColor,
              height: 40,
              child: CustomTextField(
                filled: true,
                fillColor: ColorConstant.whiteColor,
                onChanged: (v) {
                  _getSuggestions(v);
                },
                label: 'Search Address',
                contentPadding: EdgeInsets.only(left: 8, top: 10),
                sufix: Icon(Icons.search),
              ),
            ),
          ),
        ),
        body: _buildBody(),
        bottomSheet: CustomContainer(
          color: ColorConstant.whiteColor,
          padding: EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             _suggestions.isNotEmpty? SubTitle_Text(
                Title:location,
              ):SubTitle_Text(
               Title: _draggedAddress,
             ),
             _suggestions.isNotEmpty? SubTitle_Text(
                Title: "Lat: ${searchedLocationLatitude} Lan: ${searchedLocationLongitude}",
              ):
              SubTitle_Text(
                Title: "Lat: ${latt} Lan: ${longg}",
              ),
              SizedBox(height: 10,),
              PrimaryButton(
                onTap: () {
                  Navigator.pop(
                    context,
                    {
                      'locationName': _draggedAddress,
                      'latitude': latt,
                      'longitude': longg,
                    },
                  );
                },
                Label: "select address",
              )
            ],
          ),
        )
    );
  }
}
