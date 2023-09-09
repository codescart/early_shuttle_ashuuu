import 'package:early_shuttle/User%20Interface/Constant%20Widgets/Calender/Calender.dart';
import 'package:flutter/material.dart'; // Import the custom widget




class DateSelectionScreen extends StatefulWidget {
  @override
  _DateSelectionScreenState createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  DateTime selectedDate = DateTime.now();

  void _handleDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Date: ${selectedDate.toString()}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            DatePickerWidget(
              initialDate: selectedDate,
              onDateSelected: _handleDateSelected,
            ),
          ],
        ),
      ),
    );
  }
}