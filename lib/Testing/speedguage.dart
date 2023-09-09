// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:paytm/paytm.dart';
//
//
// class mycheck extends StatefulWidget {
//   @override
//   _mycheckState createState() => _mycheckState();
// }
//
// class _mycheckState extends State<mycheck> {
//    var payment_response;
//
//   // //Live
//   // String mid = "SBTour50516554054248";
//   // String PAYTM_MERCHANT_KEY = "SBTour50516554054248";
//   // String website = "DEFAULT";
//   // bool testing = false;
//
//   // Testing
//   String mid = "SBTour50516554054248";
//   String PAYTM_MERCHANT_KEY = "aohzMZVGvrF5#hLq";
//   String website = "WEBSTAGING";
//   bool testing = true;
//
//   double amount = 1;
//   bool loading = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Paytm example app'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                     'For Testing Credentials make sure appInvokeEnabled set to FALSE or Paytm APP is not installed on the device.'),
//
//                 SizedBox(
//                   height: 10,
//                 ),
//
//                 TextField(
//                   onChanged: (value) {
//                     mid = value;
//                   },
//                   decoration: InputDecoration(hintText: "Enter MID here"),
//                   keyboardType: TextInputType.text,
//                 ),
//                 TextField(
//                   onChanged: (value) {
//                     PAYTM_MERCHANT_KEY = value;
//                   },
//                   decoration:
//                   InputDecoration(hintText: "Enter Merchant Key here"),
//                   keyboardType: TextInputType.text,
//                 ),
//                 TextField(
//                   onChanged: (value) {
//                     website = value;
//                   },
//                   decoration: InputDecoration(
//                       hintText: "Enter Website here (Probably DEFAULT)"),
//                   keyboardType: TextInputType.text,
//                 ),
//                 TextField(
//                   onChanged: (value) {
//                     try {
//                       amount = double.tryParse(value)!;
//                     } catch (e) {
//                       print(e);
//                     }
//                   },
//                   decoration: InputDecoration(hintText: "Enter Amount here"),
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 payment_response != null
//                     ? Text('Response: $payment_response\n')
//                     : Container(),
// //                loading
// //                    ? Center(
// //                        child: Container(
// //                            width: 50,
// //                            height: 50,
// //                            child: CircularProgressIndicator()),
// //                      )
// //                    : Container(),
//                 ElevatedButton(
//                   onPressed: () {
//                     //Firstly Generate CheckSum bcoz Paytm Require this
//                     generateTxnToken(0);
//                   },
//                   child: Text(
//                     "Pay using Wallet",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     //Firstly Generate CheckSum bcoz Paytm Require this
//                     generateTxnToken(1);
//                   },
//                   child: Text(
//                     "Pay using Net Banking",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     //Firstly Generate CheckSum bcoz Paytm Require this
//                     generateTxnToken(2);
//                   },
//                   child: Text(
//                     "Pay using UPI",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     //Firstly Generate CheckSum bcoz Paytm Require this
//                     generateTxnToken(3);
//                   },
//                   child: Text(
//                     "Pay using Credit Card",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void generateTxnToken(int mode) async {
//
//       var paytmResponse = Paytm.payWithPaytm(
//           mId: mid,
//           orderId: "984764",
//           txnToken: "984764",
//           txnAmount: amount.toString(),
//           callBackUrl: "callBackUrl",
//           staging: testing,
//           appInvokeEnabled: true
//       );
//
//       paytmResponse.then((value) {
//         print(value);
//         setState(() {
//           loading = false;
//           print("Value is ");
//           print(value);
//           if (value['error']) {
//             payment_response = value['errorMessage'];
//           } else {
//             if (value['response'] != null) {
//               payment_response = value['response']['STATUS'];
//             }
//           }
//           payment_response += "\n" + value.toString();
//         });
//       });
//     // } catch (e) {
//     //   print(e);
//     // }
//   }
// }