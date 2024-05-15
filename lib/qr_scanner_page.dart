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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFDBE9F6), // Starting color
              Colors.white, // Ending color
            ],
            stops: [0.7, 1.0], // Gradient stops
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'QR Scanner',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: [
                              Color(0xFF5451D6), // Starting color
                              Color(0xFF1DBEF5), // Ending color
                            ],
                          ).createShader(
                            Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                          ),
                      ),
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
                        child: Text('Day 1 - 22 May'),
                      ),
                      DropdownMenuItem(
                        value: 'day_2',
                        child: Text('Day 2 - 23 May'),
                      ),
                      DropdownMenuItem(
                        value: 'day_3',
                        child: Text('Day 3 - 24 May'),
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Day',
                      border: OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: qrDataController,
                    decoration: InputDecoration(
                      labelText: 'QR Data',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff5451D6),
                          Color(0xff1DBEF5),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ElevatedButton(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/qr_scanner_icon.png', // Add your icon path
                            height: 35, // Adjust icon size as needed
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Scan QR Card',
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.white),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20), // Adjust height
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff5451D6),
                          Color(0xff1DBEF5),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: ElevatedButton(
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
                              await GoogleSheetsService
                                  .checkIfGuestExists_update(
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
                                const SnackBar(
                                    content: Text('Updated successfully')),
                              );
                            }
                            // Close loading spinner
                            if (value == 'already done') {
                              _showErrorPopup(
                                  "${result['name']} already done $selectedActivity");
                            }
                          }).catchError((error) {
                            Navigator.of(context)
                                .pop(); // Close loading spinner
                            _showErrorPopup('Error updating data: $error');
                          });
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Update',
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.white),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30), // Adjust height
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
