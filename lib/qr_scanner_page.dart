import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:iclst_app/sheets/google_sheets_service.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  TextEditingController qrDataController = TextEditingController();
  String? selectedDay;
  String? selectedActivity;
  bool isLoading = false;

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
                  value: 'day_1',
                  child: Text('Day 1 - 21 May'),
                ),
                DropdownMenuItem(
                  value: 'day_2',
                  child: Text('Day 2 - 22 May'),
                ),
                DropdownMenuItem(
                  value: 'day_3',
                  child: Text('Day 3 - 23 May'),
                ),
                DropdownMenuItem(
                  value: 'day_4',
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
              onPressed: () async {
                if (qrDataController.text.isEmpty ||
                    selectedDay == null ||
                    selectedActivity == null) {
                  _showErrorPopup('Please fill in all fields');
                } else {
                  // Show loading spinner
                  _showLoadingSpinner();

                  // Check if guest exists
                  Map<String, dynamic> result =
                      await GoogleSheetsService.checkIfGuestExists(
                          qrDataController.text, selectedDay!);
                  print(result);

                  // Call function to update data
                  GoogleSheetsService.updateQRData(
                    qrDataController.text,
                    selectedDay!,
                    selectedActivity!,
                    result,
                  ).then((value) {
                    Navigator.of(context).pop();
                    if (value == 'Updated') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Updated successfully')),
                      );
                    }
                    // Close loading spinner
                    if (value == 'already done') {
                      _showErrorPopup(
                          "${result['name']} already done $selectedActivity");
                    }
                  }).catchError((error) {
                    Navigator.of(context).pop(); // Close loading spinner
                    _showErrorPopup('Error updating data: $error');
                  });
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoadingSpinner() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Updating data...'),
            ],
          ),
        );
      },
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
