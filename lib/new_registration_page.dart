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
      appBar: AppBar(
        title: const Text('New Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
            ),
            TextFormField(
              controller: instituteController,
              decoration: const InputDecoration(
                labelText: 'Institute',
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: iclstIdController,
                    decoration: const InputDecoration(
                      labelText: 'ICLST ID',
                    ),
                  ),
                ),
                SizedBox(width: 10),
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
                        qrCodeResult = res;
                        iclstIdController.text = qrCodeResult;
                      }
                    });
                  },
                  child: const Text('Scan Card'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _registerNewGuest();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

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
    bool isIdInUse =
        await GoogleSheetsService.checkIfGuestExists(iclstIdController.text);

    // Hide 'Checking ID' loading pop-up
    Navigator.of(context).pop();

    if (isIdInUse) {
      setState(() {
// Hide loading popup
      });
      _showErrorPopup('ICLST ID is already in use');
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
