import 'package:flutter/material.dart';
import 'guest_list_page.dart'; // Import the guest_list_page.dart file
import 'new_registration_page.dart';
import 'qr_scanner_page.dart';
import 'sheets/google_sheets_service.dart'; // Import the GoogleSheetsService

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _totalRegistered = 0; // Initialize total registered count

  @override
  void initState() {
    super.initState();
    _fetchTotalRegistered(); // Fetch total registered count on initialization
  }

  // Method to fetch total registered count
  void _fetchTotalRegistered() async {
    try {
      // Fetch guest names with IDs
      final guestNamesWithIDs =
          await GoogleSheetsService.getGuestNamesWithIDs();
      // Update total registered count
      setState(() {
        _totalRegistered = guestNamesWithIDs.length;
      });
    } catch (e) {
      print('Error fetching total registered count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Hide the app bar
        child: Container(),
      ),
      body: Stack(
        children: [
          Container(
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
          ),
          Positioned(
            left: 15,
            right: 70,
            top: 5, // Adjusted position for the heading
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ICLST’24',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 45.0,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          Color(0xFF5451D6), // Starting color
                          Color(0xFF1DBEF5), // Ending color
                        ],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
                SizedBox(height: 1.0),
                Text(
                  'Centre of Excellence in Logistics and Supply Chain Management',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          Color(0xFF5451D6), // Starting color
                          Color(0xFF1DBEF5), // Ending color
                        ],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 400.0, 40.0)),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height *
                0.18, // Adjusted position for the custom image
            child: Center(
              child: Image.asset(
                'assets/center_logo.png', // Replace with your custom image path
                height: 250, // Adjust the height of the image
                width: 250, // Adjust the width of the image
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height *
                0.52, // Adjusted position for the new column
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 19.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFFDBE9F6), // Starting color
                      Colors.white, // Ending color
                    ],
                    stops: [0.0, 1.0], // Gradient stops
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Total Registered',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [
                                  Color(0xFF5451D6), // Starting color
                                  Color(0xFF1DBEF5), // Ending color
                                ],
                              ).createShader(
                                  Rect.fromLTWH(0.0, 0.0, 200.0, 20.0)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          _totalRegistered
                              .toString(), // Display total registered count
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [
                                  Color(0xFF5451D6), // Starting color
                                  Color(0xFF1DBEF5), // Ending color
                                ],
                              ).createShader(
                                  Rect.fromLTWH(0.0, 0.0, 200.0, 20.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0), // Add top margin
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the red containers horizontally
                  children: [
                    Container(
                      height: 245,
                      margin: EdgeInsets.symmetric(
                          horizontal: 5.0), // Adjusted margin
                      child: Column(
                        children: [
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
                              onPressed: () => _handleButtonPress(
                                  context, 'New Registration'),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/new_registration_icon.png', // Add your icon path
                                    height: 50, // Adjust icon size as needed
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'New Registration',
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
                                    vertical: 26.0,
                                    horizontal: 25), // Adjust height
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
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
                              onPressed: () =>
                                  _handleButtonPress(context, 'Settings'),
                              child: Text(
                                'Settings',
                                style: const TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 35.0,
                                    horizontal: 60), // Adjust height
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 245,
                      margin: EdgeInsets.symmetric(
                          horizontal: 5.0), // Adjusted margin
                      child: Column(
                        children: [
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
                              onPressed: () => _handleButtonPress(
                                  context, 'All Registration'),
                              child: Text(
                                'All Registration',
                                style: const TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 35.0,
                                    horizontal: 25), // Adjust height
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
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
                              onPressed: () =>
                                  _handleButtonPress(context, 'QR Scanner'),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/qr_scanner_icon.png', // Add your icon path
                                    height: 50, // Adjust icon size as needed
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'QR Scanner',
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
                                    vertical: 26.0,
                                    horizontal: 40), // Adjust height
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0), // Add bottom margin
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleButtonPress(BuildContext context, String label) {
    switch (label) {
      case 'New Registration':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewRegistrationPage(),
          ),
        );
        break;
      case 'QR Scanner':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRScannerPage(),
          ),
        );
        break;
      case 'All Registration':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuestListPage(),
          ),
        );
        break;
      case 'Settings':
        // Handle navigation for Settings
        break;
      default:
    }
  }
}
