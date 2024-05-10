import 'package:flutter/material.dart';
import 'package:iclst_app/sheets/google_sheets_service.dart';

class GuestListPage extends StatefulWidget {
  @override
  _GuestListPageState createState() => _GuestListPageState();
}

class _GuestListPageState extends State<GuestListPage> {
  Map<String, String> guestMap = {};
  List<String> filteredGuests = [];
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

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
      final map = await GoogleSheetsService.getGuestNamesWithIDs();
      setState(() {
        guestMap = map;
        filteredGuests = guestMap.keys.toList()..sort();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching guest list: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterGuests(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredGuests = guestMap.keys.toList()..sort();
      } else {
        filteredGuests = guestMap.keys
            .where((name) => name.toLowerCase().contains(query.toLowerCase()))
            .toList()
          ..sort();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest List'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: _filterGuests,
                  decoration: InputDecoration(
                    labelText: 'Search by Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredGuests.length,
                  itemBuilder: (context, index) {
                    final name = filteredGuests[index];
                    final id = guestMap[name];
                    return ListTile(
                      title: Text(name),
                      trailing: Text('ID: $id'),
                    );
                  },
                ),
              ),
            ],
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
