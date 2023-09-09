
import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../main.dart';


class SearchAddress extends StatefulWidget {
  final String locationType;
  const SearchAddress({Key? key, required this.locationType}) : super(key: key);

  @override
  State<SearchAddress> createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {
  String radius = "30";

  double latitude = 31.5111093;
  double longitude = 74.279664;
  var lat="0.000";
  var long="0.000";
  var latt;
  var longg;


  Completer<GoogleMapController>  _controller = Completer();
  String _draggedAddress = "";
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  _init() {
    _defaultLatLng = const LatLng(20.5937, 78.9629);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(
        target: _defaultLatLng,
        zoom: 10.5
    );
    _gotoUserCurrentPosition();
  }
  Uint8List? marketimages;
  final List<Marker> _markers =[];
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer
        .asUint8List();
  }

  Future<Uint8List?>loadNetWorkImage(String path) async{
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info,_) =>completer.complete(info))
    );
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }


  var totallen;
  Widget _getMap() {
    return GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: false,
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
        }
    );
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
      _markers.add(
          Marker(
            markerId: MarkerId('0'),
            icon: BitmapDescriptor.fromBytes(locationIcon),
            position: LatLng(lats, longs),
            infoWindow: InfoWindow(
              title: "userName",
            ),
            draggable:true,
            onDragEnd: ((newPosition) {
              print('rrrrrrrrrrrr');
              print(newPosition.latitude);
              print(newPosition.longitude);
            }),
          )
      );
    });

  }

  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: position,
                zoom: 13.5
            )
        )
    );
    await _getAddress(position);
  }
  Future _getAddress(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addresStr = "${address.street}, ${address.locality}, ${address
        .administrativeArea}, ${address.country}";
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
    if(locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    if(locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
// fetch live location from the map
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _suggestions = [];

  Future<void> _getSuggestions(String input) async {
    const apiKey = 'AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM'; // Replace with your API key
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
        _suggestions = predictions
            .map((prediction) {
          final description = prediction['description'] as String;
          final placeId = prediction['place_id'] as String;
          return {'description': description, 'place_id': placeId};
        })
            .toList();
      });
    }
  }


  Future<Map<String, double>> getLatLngFromPlaceId(String placeId, String address) async {
    const apiKey = 'AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM';
    final response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);

      if (decodedResponse['status'] == 'OK') {
        final location = decodedResponse['result']['geometry']['location'];
        searchedLocationLatitude = location['lat'];
        searchedLocationLongitude = location['lng'];
        if(searchedLocationLongitude != null && searchedLocationLatitude !=null){
          print("aaaaaaaaaaaaaa");
          print(address);
          Navigator.pop(context,
            {
              'locationName': address,
              'latitude': searchedLocationLatitude,
              'longitude': searchedLocationLongitude,
            },
          );
        }

        return {'latitude': searchedLocationLatitude, 'longitude': searchedLocationLongitude};
      } else {
        throw Exception('Failed to fetch location details: ${decodedResponse['error_message']}');
      }
    } else {
      throw Exception('Failed to fetch location details: ${response.statusCode}');
    }
  }


  Widget _getLoctionButton() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: InkWell(
        onTap:  (){
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
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
            ],
          ),
          child: Icon(Icons.my_location),
        ),
      ),
    );
  }

  Widget _getCustomPin() {
    return Positioned(
      top: height/2.8,
      left: width/2.3,
      child: InkWell(
        onTap: () async {

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                title: Text(_draggedAddress,),
                content: Container(
                  height: 200,
                  width: 400,
                  child: Column(
                    children: [
                      Text( 'Latitude '+latt.toString(),),
                      Text( 'longitude '+longg.toString(),),
                      Text( 'Adress '+_draggedAddress,),

                    ],
                  ),
                  // child:Alerts(
                  //     lats:latt.toString(),
                  //     longs:longg.toString(),
                  //     address:_draggedAddress
                  // )
                )
            ),
          );

        },
        child: Container(
          width: 50,
          height: 50,
          child: Image.asset("assets/placeholder1.png"),
        ),
      ),
    );
  }


  Widget _buildBody() {
    return Stack(
        children : [
          _getMap(),
          _getCustomPin(),
          _getLoctionButton(),
          _suggestions.isNotEmpty? Container(
            color: Colors.white,
            height:height/3,
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
                  title: Text( location.toString(),),
                  onTap: () {
                    getLatLngFromPlaceId(placeId, location.toString());
                    print('aaaaaaaaaaaaaaa');
                    // print(latt.toString()+long.toString()+_draggedAddress);
                  },
                );
              },
            ),
          ):SizedBox(),
        ]
    );
  }


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
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Choose your Location", style: TextStyle(color: Colors.black),),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child:Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 4,
                        blurRadius: 10
                    )
                  ],
                  borderRadius: BorderRadius.circular(8)
              ),
              child: TextFormField(
                // controller: destinationcon,
                // onTap: ()async{
                //   String selectedPlace = await showGoogleAutoComplete();
                //   destinationcon.text=selectedPlace;
                //   setState(() {
                //     _searchAddress=selectedPlace;
                //     _searchAndSetMarker();
                //   });
                // },
                onChanged: (v){
                  _getSuggestions(v);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left:8,top: 10),
                    hintText: 'Search Address',
                    suffixIcon:Icon(Icons.search),
                    border: InputBorder.none
                ),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffA7A7A7),
                ),
              ),
            ),
          ),
        ),
        body:_buildBody() ,
        bottomSheet: Container(
          padding: EdgeInsets.all(10),
          height: 60,
          width:width,
          decoration:  BoxDecoration(
            color: Colors.transparent,
          ),
          child: ElevatedButton(
              onPressed: () async {
                Navigator.pop(context,
                  {
                    'locationName': _draggedAddress,
                    'latitude': latt,
                    'longitude': longg,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color(
                  0xffa1d567,
                ).withOpacity(0.6),
              ),
              child:
              Text(
                'select address',
                style: GoogleFonts.alike(
                  textStyle:  TextStyle(
                    fontSize:height/30,
                  ),
                ),
              )
          ),
        )
    );
  }
}