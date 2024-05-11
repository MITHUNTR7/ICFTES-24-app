import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:iclst_app/sheets/google_sheets_service.dart';

class NewRegistrationPage extends StatefulWidget {
  @override
  _NewRegistrationPageState createState() => _NewRegistrationPageState();
}

class _NewRegistrationPageState extends State<NewRegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController iclstIdController = TextEditingController();

  String qrCodeResult = '';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'New Registration',
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
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: instituteController,
                    decoration: const InputDecoration(
                      labelText: 'Institute',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: iclstIdController,
                          decoration: const InputDecoration(
                            labelText: 'ICLST ID',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
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
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SimpleBarcodeScannerPage(),
                              ),
                            );
                            setState(() {
                              if (res is String) {
                                qrCodeResult = res;
                                iclstIdController.text = qrCodeResult;
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/qr_scanner_icon.png', // Add your icon path
                                height: 35, // Adjust icon size as needed
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 20), // Adjust height
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () => _registerNewGuest(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register',
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
                            vertical: 15.0, horizontal: 40), // Adjust height
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

//SimpleBarcodeScannerPage(),
  void _registerNewGuest() async {
    // Check if any input field is empty
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        instituteController.text.isEmpty ||
        iclstIdController.text.isEmpty) {
      _showErrorPopup('Please fill in all fields');
      return;
    }

    setState(() {
// Show loading popup
    });

    // Show 'Checking ID' loading pop-up
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return _buildLoadingPopup('Checking ID');
      },
    );

    // Check if the provided ICLST ID is already in use
    Map<String, dynamic> result = await GoogleSheetsService.checkIfGuestExists(
        iclstIdController.text, 'guest_list');

    String name = result['name'];

    // Hide 'Checking ID' loading pop-up
    Navigator.of(context).pop();

    if (result['if_exists']) {
      setState(() {
        // Hide loading popup
      });
      _showErrorPopup('$name has already used the ICLST ID');
      return;
    }

    // Register the new guest
    try {
      // Show loading popup during registration
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return _buildLoadingPopup('Registering');
        },
      );

      await GoogleSheetsService.addGuest(
        iclstIdController.text,
        nameController.text,
        phoneController.text,
        instituteController.text,
      );

      // Clear input fields after successful registration
      nameController.clear();
      phoneController.clear();
      instituteController.clear();
      iclstIdController.clear();

      // Hide loading popup after registration is completed
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Guest registered successfully')),
      );
    } catch (e) {
      // Hide loading popup if an error occurs
      Navigator.of(context).pop();
      _showErrorPopup('Error registering guest: $e');
    } finally {
      // Hide loading popup in case of any errors
      setState(() {});
    }
  }

  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingPopup(String message) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(message),
        ],
      ),
    );
  }
}
