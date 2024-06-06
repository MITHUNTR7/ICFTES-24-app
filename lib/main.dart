import 'package:flutter/material.dart';
import 'guest_list_page.dart'; // Import the guest_list_page.dart file
import 'new_registration_page.dart';
import 'qr_scanner_page.dart';
import 'sheets/google_sheets_service.dart'; // Import the GoogleSheetsService
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

final Uri _url = Uri.parse(
    'https://docs.google.com/spreadsheets/d/1qglftjbYoytykTbP-FXiGpF1aHR9dSiVJiVn4UeNY0M');

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICFTES Admin App',
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
      final guestNamesWithIDs =
          await GoogleSheetsService.getGuestNamesWithIDs();
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFFE0F7FA), // Starting color
                Color(0xFFFFFFFF), // Ending color
              ],
              stops: [0.7, 1.0], // Gradient stops
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ICFTES’24',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 45.0,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: [
                                      Color(0xFF00796B), // Starting color
                                      Color(0xFF004D40), // Ending color
                                    ],
                                  ).createShader(
                                      Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                              ),
                            ),
                            SizedBox(height: 1.0),
                            Text(
                              'International Conference on Fluid, Thermal and Energy Systems',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: [
                                      Color(0xFF00796B), // Starting color
                                      Color(0xFF004D40), // Ending color
                                    ],
                                  ).createShader(
                                      Rect.fromLTWH(0.0, 0.0, 400.0, 40.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/center_logo.png', // Replace with your custom image path
                          height: 250, // Adjust the height of the image
                          width: 250, // Adjust the width of the image
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
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
                                Color(0xFFE0F7FA), // Starting color
                                Color(0xFFFFFFFF), // Ending color
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
                                            Color(0xFF00796B), // Starting color
                                            Color(0xFF004D40), // Ending color
                                          ],
                                        ).createShader(Rect.fromLTWH(
                                            0.0, 0.0, 200.0, 20.0)),
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
                                            Color(0xFF00796B), // Starting color
                                            Color(0xFF004D40), // Ending color
                                          ],
                                        ).createShader(Rect.fromLTWH(
                                            0.0, 0.0, 200.0, 20.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 245,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Color(0xFF00796B),
                                              Color(0xFF004D40),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () => _handleButtonPress(
                                              context, 'New Registration'),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/new_registration_icon.png',
                                                height:
                                                    50, // Adjust icon size as needed
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'New Registration',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0,
                                                horizontal:
                                                    15), // Adjust height
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Color(0xFF00796B),
                                              Color(0xFF004D40),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () => _handleButtonPress(
                                              context, 'Sheets'),
                                          child: Text(
                                            'Google Sheets',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal:
                                                    15), // Adjust height
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 245,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Color(0xFF00796B),
                                              Color(0xFF004D40),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () => _handleButtonPress(
                                              context, 'All Registration'),
                                          child: Text(
                                            'All Registration',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal:
                                                    15), // Adjust height
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Color(0xFF00796B),
                                              Color(0xFF004D40),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () => _handleButtonPress(
                                              context, 'QR Scanner'),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/qr_scanner_icon.png',
                                                height:
                                                    50, // Adjust icon size as needed
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                'QR Scanner',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0,
                                                horizontal:
                                                    30), // Adjust height
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0), // Add bottom margin
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
      case 'Sheets':
        _launchUrl();
        break;
      default:
        print('Unknown button label');
    }
  }

  Future<void> _launchUrl() async {
    try {
      if (await canLaunchUrl(_url)) {
        await launchUrl(_url);
      } else {
        throw Exception('Could not launch $_url: Unsupported URL');
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Handle error launching URL
    }
  }
}
