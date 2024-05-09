import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart'; // Importing the intl package for date formatting

class GoogleSheetsService {
  // Credentials
  static const _credentials = {
    "type": "service_account",
    "project_id": "iclst-422205",
    "private_key_id": "cd3081afea77b36cef3e6a549b3b5372f67afdfe",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCq8tqE70MHkgCO\nt/0kMVCQ8huF+e87gedJ0QiNe0G67WvmA/joXbWj1x+8ihs2NVq5P5L5nS0Q/w6m\nt/pZuwBkSX7kF5TtwowShS3SgM3FUBBtLyfoJcLeCPbUq4X4tCrvVueqX2WPxxWo\n7XRVuQE6lL4EO8znt1/KM5Z8+LUtY7RgCnOqRFApdpUk9zjuyqQK2q1jd5sIsxoq\n96ESjVwKP0u/BNZiANYleEy0QiMPVgUB+adQmjgBUqGYomh0oRcefZqMro3e0t24\nNWenfIosF6sMhL8IATU+0Izv7KPYyNiIUr21j7od7QJZjsf4I+Upec5mrlg/7nB/\nmXNTnfG7AgMBAAECggEAIQ4pq/fZ9b5JJk+0fsmcYxK1uL/d/xs83nyxky4IxT0A\nlq8g88mfBGnmJJ5t6ZsCinydDnBSlQ1Ex38exTgQONQvWaqnrRvn2vLuq9wlLeiv\n7HToWg7nMej41aG/G5q3DKW40Sx2JomgChS0YJkQAERfw9DOa+X8+0vjZxHucrKZ\nq9ISh2qmsmhDetzAkJzdJoD/86n546/eYdElIYZ0WfRtEpm4oS2dNM7TDCZhavpk\nQ3nz2KJd770mXkWqzxBfaUIdC1U0xtJvivaDCbRV9gc4SenPwg5fqVvEXsRn/LC/\nnZxA+9Is3Pk1USdOVj/gjaWyA/AZ192aODTyi4G+DQKBgQDwwbleRjm1cobvYLdc\nc0pihn45EHLOxlvC7Cuh1kM5+ISyEaUg9BmVHFibM5N1HBh2s3Hrew8eS1Q9ApRU\nley2EL4dnAGwWH3ss7aVljS2zpgex5OB5z7XPzABF5qlXSWR1Dzk6iIHzxmx+jBX\n+CaAwkZXMzNwH8Itmj4aAVE5DwKBgQC1xadYh59LDMWcblv5BPYvcyBgeSj8v7cA\nlqGYf63b4caUPhl+pUeyb9Dr72qzdTV4c6KvjNCNAduQV/SpsAk+tX+bDRfjopGe\nWzAWFzt9TPhQhYDgSStMTC5dRTgxJUsCx5o0D/APtyINbbBndr0GZXBCB15OZSGA\nn+bSu1SElQKBgFsEYdfKJLb7/RcyMR+6Vjy5K67XERAq3TXrovMj1XZtBX1sPkke\n/yzn8nd6IBz96iG15TNo6mZBhC8scncn1r1dxwHaoKjSS4jYyAX1KyiRIeFBAfry\nOUeWk8dV7RjnBfUDj6HbAdKB8Ozf8LbREX1L9Nuyd5fD6dzjmuap6NLxAoGARvZH\n0372yATPbLeEvl2agoGuZRtHzgxGNDuaEH/f7tRgguUPbOq3Z8jRRhpsjGy4mDKE\nk4YksLfF8L71q/0mTs3qaCyfY+XGdYzh4+3j8pHG6yCDZIwMFDg1bYIlYsJNW2Nz\nJtoF/QyghZ+J24p2VvXo8k4QGgjPIHjMUv6BC1UCgYAxlshSjDVsPmlzchKQZxMS\nkUBv8jQxFADEkjtuiyMbAMaXNJg7iiezS58HbxiIwgaks3H2ZAx/o0BY7StNgpkA\nLA4sANaA3erRoUxeDwf80NCz5obTtGDkywrmeKF0qeO4OZqecbrLa41jcAuIzzwR\nL4FYvJX9Gu8KeuvE8XnuFw==\n-----END PRIVATE KEY-----\n",
    "client_email": "gsheets@iclst-422205.iam.gserviceaccount.com",
    "client_id": "118160749891228162003",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40iclst-422205.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };

  // Your spreadsheet ID
  static const _spreadsheetId = '1u9fKUvVymHb-W6iY0UGIoE-nb3hzxAAXhRQfktpiSoc';

  //####################################################### GET ALL GUEST ##############################

  static Future<List<String>> getGuestNames() async {
    try {
      // Initialize GSheets
      final gsheets = GSheets(_credentials);

      // Fetch spreadsheet by its ID
      final ss = await gsheets.spreadsheet(_spreadsheetId);

      // Get the worksheet by its title
      final sheet = ss.worksheetByTitle('guest_list');

      // Ensure the sheet is not null
      if (sheet != null) {
        // Fetch names from the sheet (2nd column) and sort them alphabetically
        final names = await sheet.values.columnByKey('Name') ?? [];
        names.sort();
        // Return the list of names
        return names.cast<String>();
      } else {
        throw ('Worksheet not found');
      }
    } catch (e) {
      throw ('Error fetching guest names: $e');
    }
  }

  //####################################################### CHECK IF GUEST EXIST #######################

  static Future<bool> checkIfGuestExists(String id) async {
    try {
      // Initialize GSheets
      final gsheets = GSheets(_credentials);

      // Fetch spreadsheet by its ID
      final ss = await gsheets.spreadsheet(_spreadsheetId);

      // Get the worksheet by its title
      final sheet = ss.worksheetByTitle('guest_list');

      if (sheet != null) {
        // Fetch all values in the 'ID' column
        final idColumn = await sheet.values.columnByKey('ID') ?? [];

        // Check if the given ID exists in the 'ID' column
        if (idColumn.contains(id)) {
          // Get the index of the ID
          final index = idColumn.indexOf(id);

          // Fetch the 'Name' column values
          final names = await sheet.values.columnByKey('Name') ?? [];

          // Check if the 'Name' column has any value at the corresponding index
          if (index >= 0 && index < names.length && names[index].isNotEmpty) {
            return true;
          }
        }
      } else {
        throw ('Worksheet not found');
      }
    } catch (e) {
      throw ('Error checking if guest exists: $e');
    }
    return false;
  }

  //####################################################### ADD NEW GUEST ##############################

  static Future<void> addGuest(
      String id, String name, String phone, String institute) async {
    try {
      // Initialize GSheets
      final gsheets = GSheets(_credentials);

      // Fetch spreadsheet by its ID
      final ss = await gsheets.spreadsheet(_spreadsheetId);

      // Get the worksheet by its title
      final sheet = ss.worksheetByTitle('guest_list');

      if (sheet != null) {
        // Check if the guest ID already exists
        if (await checkIfGuestExists(id)) {
          throw ('Guest with ID $id already exists');
        }

        // Find the index of the given ID
        final idColumn = await sheet.values.columnByKey('ID') ?? [];
        final index = idColumn.indexOf(id);

        // Create the new row with Registration_Date_Time
        final DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
        final String formattedDate = formatter.format(DateTime.now());
        final newRow = {
          'ID': id,
          'Name': name,
          'Phone': phone,
          'Institute': institute,
          'Registration_Date_Time': formattedDate,
        };

        // Convert the newRow map into a list
        final List<dynamic> newRowList = newRow.values.toList();

        // Append the new row at the found index
        await sheet.values.insertRow(index + 2, newRowList);
      } else {
        throw ('Worksheet not found');
      }
    } catch (e) {
      print('Error adding guest: $e');
      // Show error popup
    }
  }
}
