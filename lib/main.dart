import 'package:flutter/material.dart';
import 'guest_list_page.dart'; // Import the guest_list_page.dart file
import 'new_registration_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICLST Admin App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ICLST Admin App'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            _buildButton(context, 'Guests List'),
            _buildButton(context, 'New Registration'),
            _buildButton(context, 'QR Scanner'),
            _buildButton(context, 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          // Handle button press
          if (label == 'Guests List') {
            // Navigate to GuestListPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GuestListPage(),
              ),
            );
          } else if (label == 'New Registration') {
            // Navigate to NewRegistrationPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewRegistrationPage(),
              ),
            );
          } else if (label == 'QR Scanner') {
            // Navigate to QR Scanner page
          } else if (label == 'Settings') {
            // Navigate to Settings page
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
