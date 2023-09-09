import 'package:flutter/material.dart';

class findDeviceheight extends StatelessWidget {
  const findDeviceheight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
          "Height: ${MediaQuery.of(context).size.height} \nWidht: ${MediaQuery.of(context).size.width}"),
    ));
  }
}
