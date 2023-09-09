// import 'dart:convert';
// import 'package:early_shuttle/Constant/assets.dart';
// import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/titleStyle.dart';
// import 'package:flutter/foundation.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Container/Container_widget.dart';
// import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Text%20Field/TextField_widget.dart';
// import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/AppBarTitle.dart';
// import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/smallTextStyle.dart';
// import 'package:early_shuttle/User%20Interface/Constant%20Widgets/TextStyling/subtitleStyle.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
// import '../../../Constant/color.dart';
// import '../../../Constant/url.dart';
//
//
// class addpopup extends StatefulWidget {
//   const addpopup({super.key,});
//
//   @override
//   State<addpopup> createState() => _addpopupState();
// }
//
// class _addpopupState extends State<addpopup> {
//
//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//     _fetchData();
//   }
//   // Api Routes data
//   List<dynamic> _allRoutes = [];
//   List<dynamic> _filteredSuggestions = [];
//   Future<void> _fetchData() async {
//     final response = await http.get(Uri.parse(AppUrls.GetAllStopsApiUrl));
//     if (response.statusCode == 200) {
//       setState(() {
//         _allRoutes = json.decode(response.body)['data'];
//         _filteredSuggestions.addAll(_allRoutes); // Initialize filteredSuggestions
//       });
//     }
//   }
//
//   void _filterSuggestions(String query) {
//     setState(() {
//       _filteredSuggestions = _allRoutes.where((suggestion) {
//         final name = suggestion['name'].toLowerCase();
//         return name.contains(query.toLowerCase());
//       }).toList();
//     });
//   }
//
//
//
//   // Fetch Places data on the behalf of search........
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _suggestions = [];
//
//   Future<void> _getSuggestions(String input) async {
//     const apiKey = 'AIzaSyBKIlvYYdvExdOrvjZZFxvm1KsAC99aLzM'; // Replace with your API key
//     final endpoint = Uri.parse(
//       'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey',
//     );
//
//     final response = await http.get(endpoint);
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final predictions = data['predictions'];
//       if (kDebugMode) {
//         print("saaaaaaaaaaaaaaaaaa");
//       }
//       if (kDebugMode) {
//         print(predictions);
//       }
//       setState(() {
//         _suggestions = predictions
//             .map((prediction) => prediction['description'] as String)
//             .toList();
//       });
//     }
//   }
//
//   // Get live location......
//   String locationText = 'Location: Not available';
//   Future<void> _getLocation() async {
//     await Geolocator.requestPermission();
//     try {
//       final Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       setState(() {
//         locationText =
//         'Location: ${position.latitude}, ${position.longitude}';
//         searchedLocationLatitude= position.latitude;
//         searchedLocationLongitude= position.longitude;
//       });
//       _getAddress(LatLng(position.latitude, position.longitude));
//     }
//     catch (e) {
//       if (kDebugMode) {
//         print('Error getting location: $e');
//       }
//       setState(() {
//         locationText = 'Location: Error';
//       });
//     }
//   }
//   // Fetch live location from lat lan..............
//   var liveLocation;
//   var searchedLocationLatitude;
//   var searchedLocationLongitude;
//
//   Future _getAddress(LatLng position) async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
//     Placemark address = placemarks[0];
//     setState(() {
//       liveLocation = "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
//     });// get only first and closest address
//   }
//
//   String? location;
//   bool? change = false;
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Dialog(
//       child: Container(
//         decoration: BoxDecoration(
//           color: ColorConstant.whiteColor,
//           borderRadius: BorderRadius.circular(10)
//         ),
//         padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
//         child: Column(
//
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomTextField(
//               autofocus:true,
//               controller: _searchController,
//               // onChanged: _getSuggestions,
//               onChanged: (v){
//                 _getSuggestions(v);
//                 if (v.isNotEmpty) {
//                   _filterSuggestions(v);
//                 } else {
//                   setState(() {
//                     _filteredSuggestions = [..._allRoutes]; // Reset to all suggestions when query is empty
//                   });
//                 }
//               },
//               width: width/1.1,
//               height: 45,
//               filled: true,
//               fillColor: ColorConstant.greyColor.withOpacity(0.2),
//               label:"Enter location",
//             ),
//             const SizedBox(height: 10,),
//             SizedBox(
//               height:height/3.5,
//               child:_suggestions.length != 0? ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: _suggestions.length,
//                 itemBuilder: (context, index) {
//                   location = _suggestions[index];
//                   return ListTile(
//                     contentPadding: const EdgeInsets.all(0),
//                     leading: const Icon(Icons.location_on_outlined),
//                     title: SubTitle_Text(
//                       alignment: Alignment.centerLeft,
//                       Title: location,),
//                     onTap: () {
//                       print(location);
//                       Navigator.pop(context,
//                         {
//                           'locationName': location,
//                           'latitude': searchedLocationLatitude,
//                           'longitude': searchedLocationLongitude,
//                         },
//                       );
//                     },
//                   );
//                 },
//               ):Center(child: Text(
//                   "Search your location.. ", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600),),
//               ),
//             )
//           ],
//         ),
//       ),
//
//     );
//   }
// }
