import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  TextEditingController qrDataController = TextEditingController();
  String? selectedDay;
  String? selectedActivity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SimpleBarcodeScannerPage(),
                  ),
                );
                setState(() {
                  if (res is String) {
                    qrDataController.text = res;
                  }
                });
              },
              child: Text('Scan QR Card'),
            ),
            TextFormField(
              controller: qrDataController,
              decoration: InputDecoration(
                labelText: 'QR Data',
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedDay,
              onChanged: (value) {
                setState(() {
                  selectedDay = value;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Day 1 - 21 May',
                  child: Text('Day 1 - 21 May'),
                ),
                DropdownMenuItem(
                  value: 'Day 2 - 22 May',
                  child: Text('Day 2 - 22 May'),
                ),
                DropdownMenuItem(
                  value: 'Day 3 - 23 May',
                  child: Text('Day 3 - 23 May'),
                ),
                DropdownMenuItem(
                  value: 'Day 4 - 24 May',
                  child: Text('Day 4 - 24 May'),
                ),
              ],
              decoration: InputDecoration(
                labelText: 'Day',
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedActivity,
              onChanged: (value) {
                setState(() {
                  selectedActivity = value;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Breakfast',
                  child: Text('Breakfast'),
                ),
                DropdownMenuItem(
                  value: 'Lunch',
                  child: Text('Lunch'),
                ),
                DropdownMenuItem(
                  value: 'Dinner',
                  child: Text('Dinner'),
                ),
              ],
              decoration: InputDecoration(
                labelText: 'Activity',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (qrDataController.text.isEmpty ||
                    selectedDay == null ||
                    selectedActivity == null) {
                  _showErrorPopup('Please fill in all fields');
                } else {
                  // Add functionality to update data
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
