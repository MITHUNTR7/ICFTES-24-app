import 'package:flutter/material.dart';
import 'package:iclst_app/sheets/google_sheets_service.dart';

class GuestListPage extends StatefulWidget {
  @override
  _GuestListPageState createState() => _GuestListPageState();
}

class _GuestListPageState extends State<GuestListPage> {
  List<String> guestList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadGuestList();
  }

  Future<void> _loadGuestList() async {
    setState(() {
      isLoading = true;
    });

    try {
      final list = await GoogleSheetsService.getGuestNames();
      setState(() {
        guestList = list.where((name) => name.isNotEmpty).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching guest list: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest List'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: guestList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(guestList[index]),
              );
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
