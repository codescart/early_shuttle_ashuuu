// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:early_shuttle/Constant/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Text%20Field/TextField_widget.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import '../../../Constant/SharedPreference.dart';
import '../../../Constant/color.dart';
import '../../../Constant/url.dart';

class SearchForPage extends StatefulWidget {
  final String locationType;
  const SearchForPage({super.key, required this.locationType});

  @override
  State<SearchForPage> createState() => _SearchForPageState();
}

class _SearchForPageState extends State<SearchForPage> {
  @override
  void initState() {
    super.initState();
    _getLocation();
    _fetchData();
  }

  List<List<Map<String, dynamic>>> _allRoutes = [];
  List<Map<String, dynamic>> _filteredSuggestions = [];

  Future<void> _fetchData() async {
    // Replace with your actual API endpoint
    final String token = SharedPreferencesUtil.getUserAccessToken();
    final String userId = SharedPreferencesUtil.getUserId();

    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json",
    };

    final data = {
      "user_id": userId
    };

    final response = await http.post(
      Uri.parse(AppUrls.GetAllStopsApiUrl),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _allRoutes = List<List<Map<String, dynamic>>>.from(
          json.decode(response.body)['data'].map<List<Map<String, dynamic>>>(
              (route) => List<Map<String, dynamic>>.from(
                  route.map<Map<String, dynamic>>(
                      (stop) => Map<String, dynamic>.from(stop)))),
        );
        _filteredSuggestions
            .addAll(_allRoutes.expand((innerList) => innerList));
      });
    }
  }

  void _filterSuggestions(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _filteredSuggestions =
            _allRoutes.expand((innerList) => innerList).where((suggestion) {
          final name = suggestion['name'].toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList();
      } else {
        // If no search query, show all suggestions
        _filteredSuggestions =
            _allRoutes.expand((innerList) => innerList).toList();
      }
    });
  }

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
      final predictions = data['predictions'];
      if (kDebugMode) {
        print("saaaaaaaaaaaaaaaaaa");
      }
      if (kDebugMode) {
        print(predictions);
      }
      setState(() {
        _suggestions = predictions
            .map((prediction) => prediction['description'] as String)
            .toList();
      });
    }
  }

  // Get live location......
  String locationText = 'Location: Not available';
  Future<void> _getLocation() async {
    await Geolocator.requestPermission();
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        locationText = 'Location: ${position.latitude}, ${position.longitude}';
        searchedLocationLatitude = position.latitude;
        searchedLocationLongitude = position.longitude;
      });
      _getAddress(LatLng(position.latitude, position.longitude));
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
      setState(() {
        locationText = 'Location: Error';
      });
    }
  }

  // Fetch live location from lat lan..............
  var liveLocation;
  var searchedLocationLatitude;
  var searchedLocationLongitude;

  Future _getAddress(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0];
    setState(() {
      liveLocation =
          "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    }); // get only first and closest address
  }

  String? location;

  bool? change = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor: ColorConstant.primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            )),
        title: HeadingOne(
          Title: "Search Location",
        ),
        bottom: PreferredSize(
          preferredSize: Size(width, 50),
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: CustomTextField(
              autofocus: true,
              controller: _searchController,
              // onChanged: _getSuggestions,
              onChanged: (v) {
                _getSuggestions(v);
                if (v.isNotEmpty) {
                  _filterSuggestions(v);
                } else {
                  setState(() {
                    // _filteredSuggestions = [..._allRoutes]; // Reset to all suggestions when query is empty
                  });
                }
              },
              width: width / 1.1,
              height: 45,
              filled: true,
              fillColor: ColorConstant.whiteColor,
              label: "Enter the location",
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              HeadingOne(
                padding: const EdgeInsets.only(left: 5),
                fontSize: 18,
                Title: "Recent Searches",
                textColor: ColorConstant.darkBlackColor,
              ),
              const Divider(),
              // SizedBox(
              //   height:height/3.5,
              //   child:  ListView.builder(
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: _filteredSuggestions.length,
              //     itemBuilder: (context, index) {
              //       final suggestion = _filteredSuggestions[index];
              //       return ListTile(
              //         contentPadding: const EdgeInsets.all(0),
              //         leading: Image.asset(Graphics.allstops, scale: 4,),
              //         title: SubTitle_Text(
              //           alignment: Alignment.centerLeft,
              //           Title: suggestion['name'],),
              //         onTap: () {
              //           print(suggestion['latitude']);
              //           print(suggestion['longitude']);
              //           Navigator.pop(context,
              //             {
              //               'locationName': suggestion['name'].toString(),
              //               'latitude': suggestion['latitude'].toString(),
              //               'longitude': suggestion['longitude'].toString(),
              //             },
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),

              SizedBox(
                // height: height / 2,
                child: _allRoutes.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : _filteredSuggestions.isEmpty
                        ? Center(
                            child: Text('No stops found.'),
                          )
                        : ListView.builder(
                  shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            itemCount: _filteredSuggestions.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final stop = _filteredSuggestions[index];
                              return ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: Image.asset(
                                  Graphics.allstops,
                                  scale: 4,
                                ),
                                title: SubTitle_Text(
                                  alignment: Alignment.centerLeft,
                                  Title: stop['name'],
                                ),
                                onTap: () {
                                  Map<String, String> locationData = {
                                    'locationName': stop['name'].toString(),
                                    'latitude': stop['latitude'].toString(),
                                    'longitude': stop['longitude'].toString(),
                                  };
                                  Navigator.pop(context, locationData);
                                },
                              );
                            },
                          ),
              ),

              const SizedBox(
                height: 5,
              ),
              SizedBox(
                // height: height / 3.5,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    location = _suggestions[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(Icons.location_on_outlined),
                      title: SubTitle_Text(
                        alignment: Alignment.centerLeft,
                        Title: location,
                      ),
                      onTap: () {
                        Navigator.pop(
                          context,
                          {
                            'locationName': location,
                            'latitude': searchedLocationLatitude,
                            'longitude': searchedLocationLongitude,
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
