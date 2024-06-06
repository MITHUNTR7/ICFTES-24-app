import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart'; // Importing the intl package for date formatting

class GoogleSheetsService {
  // Credentials
  static const _credentials = {
    "type": "service_account",
    "project_id": "icftes-app",
    "private_key_id": "b73b78db54b75eafc985215f904332c0e95ead56",
    "private_key": "-----BEGIN PRIVATE KEY-----\n"
        "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDvHzCG/dzDRtPo\n"
        "ozynnj6UlJEtLc9n/nC1msTJwhhhdd+j9Jqxv5Ki6RJrEwlZcyBU3kFA7S13Bbpi\n"
        "7e6KpV4ZH51AiIEMUP3zIovXTfLUrmRyY6FgwHq5BUWIrBZqCPaumzy/uknP8yYm\n"
        "XbY6+523OG8eL3H3PRMQ1XJZTbW3I+H4wR5v560hl5tivuKrAbXAyYQL0WM4Jx+A\n"
        "uyL7UBu2PJeEeDh2Lus7H7/DFs7aHwhou9/UsUFhbuULPKCtwAZLe40/r5eAHfAI\n"
        "XNp8mQvQ1+9g3Q0+QCS/C1P6nsMO/5PL4ZUKg+v2aTU2iDlHM4Tlix9M/UBk4fdd\n"
        "NjKFNOIbAgMBAAECggEAcM8gD69YJPAXLNtF1DX9hA8K5muEO6V3+tUHHb/pzKDV\n"
        "Xv4YtN6SCTU3sTgL4x1DFYa89ipuloYnRmDFdrdJS0T05OsBJpRXGgskOfDWLKwR\n"
        "Sz3hdkmYHA12nmHBOUj9R6aI5FK4W9h0GQmA3Razcyq2kWEEvQUdJ4XrKmJU5g6o\n"
        "FIi3dun/MvZgEPtI2ZBLkQRXkA+62ToNA/m88HWUHkgdlOZJbprj5HVWb1rEUDcq\n"
        "sUhhW7C8DBB/iIBeRLc9dFOoiSDc+iK7uf3jaD922RMCpcH6QONbUqzulEdW+pZj\n"
        "r5t+a1ujwpYSMX5yESvRd6TqgtmA66bRpwpcK54jAQKBgQD+b0Tw1Uctx3Ew4v4z\n"
        "kk/43ZYFjPyrAPuZZNgR8/0XylZ199JUkEw+Yfiog2bhGJ/uXeGqkNNzrR7OiXRW\n"
        "DIoy+mU72Kj5Sd5wWwCdpV0H8LyESqXQVux4Ot9qiifHP1IMI2U0L0pum6HefqGO\n"
        "AdJsLgOsVMqegmBB/9+5YZ65QQKBgQDwl82FQkBESp7QlGzCdu1pFVhrAETsEsOK\n"
        "wxYc+7YjZy+K2HoenLRWHNsn9/TJpaWhEYAmXE7gfkX04cw1uNymGFw11xeGW3on\n"
        "uKyGctMIW9PZPLIlSDBqghU24U4JfYd9TudFwdqw/JITVu/2eQwW0STmT7eHGQpq\n"
        "nT4SBT8IWwKBgFb6qtK51m9r8uIHd2ch6XzmI1cab3X2DAzQUJ0yj58GaLBDW//U\n"
        "pHve+iaBZTYmOOY/6dlpUSAGWrW4f7C68LOkrd7bnkg6XHSEZ5183mTMg2WmLzEd\n"
        "xhED70R4nkia+O11XC+Oyx8szRVGrOvi65BX2qGbCvlNEKL/WfgBy0UBAoGBAKA9\n"
        "arujaWxSir3+7QUD8pF3jwENF9pnkOcdkd/R4fhoZCjEj2lOE2n7JBfVtKqM8eh5\n"
        "4HEsL7ijQXKc5MavDf5t4RRW4qswyAYmoHmXhmhdyJY6L6hXETAO3ZREsRXvDktu\n"
        "Puid+UrBnYTV9VKiQmP7/eiLFYAcNGzXt5yG8/lbAoGBANpX4Mka/oWaCEtpX2CK\n"
        "nD+uFKKPma8kDYpLnP5oWI7u1PcIMvWWpT1mYDaQwL6Ujz8GeEzGgOOBxofPF0uT\n"
        "YiuE9m1PVRazLUeI7odj7vhn8IdrxFNhg0uu1+9d9pTwkzWJAWlHFaZ3NA4DjnrW\n"
        "pI9y+DEr8i/yUtsrh5jiPWvk\n-----END PRIVATE KEY-----\n",
    "client_email": "icftes@icftes-app.iam.gserviceaccount.com",
    "client_id": "112288024848976293452",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url":
        "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/icftes%40icftes-app.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };

  // Your spreadsheet ID
  static const _spreadsheetId = '1qglftjbYoytykTbP-FXiGpF1aHR9dSiVJiVn4UeNY0M';

  //####################################################### GET ALL GUEST ##############################

  static Future<Map<String, String>> getGuestNamesWithIDs() async {
    try {
      // Initialize GSheets
      final gsheets = GSheets(_credentials);

      // Fetch spreadsheet by its ID
      final ss = await gsheets.spreadsheet(_spreadsheetId);

      // Get the worksheet by its title
      final sheet = ss.worksheetByTitle('guest_list');

      // Ensure the sheet is not null
      if (sheet != null) {
        // Fetch names and IDs from the sheet (2nd and 1st columns) and sort them alphabetically
        final names = await sheet.values.columnByKey('Name') ?? [];
        final ids = await sheet.values.columnByKey('ID') ?? [];
        final Map<String, String> guestMap = {};

        // Combine names and IDs into a map
        for (int i = 0; i < names.length; i++) {
          if (names[i].isNotEmpty && ids[i].isNotEmpty) {
            guestMap[names[i]] = ids[i];
          }
        }

        return guestMap;
      } else {
        throw ('Worksheet not found');
      }
    } catch (e) {
      throw ('Error fetching guest names: $e');
    }
  }

  //####################################################### CHECK IF GUEST EXIST #######################

  static Future<Map<String, dynamic>> checkIfGuestExists_reg(
      String id, String sheetName) async {
    try {
      final gsheets = GSheets(_credentials);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      final sheet = ss.worksheetByTitle(sheetName);
      if (sheet != null) {
        final idColumn = await sheet.values.columnByKey('ID') ?? [];
        if (idColumn.contains(id)) {
          final index = idColumn.indexOf(id);
          final names = await sheet.values.columnByKey('Name') ?? [];
          if (index >= 0 && index < names.length && names[index].isNotEmpty) {
            final name = names[index];
            return {'if_exists': true, 'name': name, 'index': index};
          }
        } else if (RegExp(r'^ICFTES_\d{4}$').hasMatch(id)) {
          // Check if the ID is valid based on the format
          return {'if_exists': false, 'name': 'none', 'index': -1};
        }
      }
    } catch (e) {
      throw ('Error checking if guest exists: $e');
    }
    return {'if_exists': null, 'name': 'none', 'index': 0};
  }

  static Future<Map<String, dynamic>> checkIfGuestExists_update(
      String id, String sheetName) async {
    try {
      final gsheets = GSheets(_credentials);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      final sheet = ss.worksheetByTitle(sheetName);
      if (sheet != null) {
        final idColumn = await sheet.values.columnByKey('ID') ?? [];
        if (idColumn.contains(id)) {
          final index = idColumn.indexOf(id);
          final names = await sheet.values.columnByKey('Name') ?? [];
          if (index >= 0 && index < names.length && names[index].isNotEmpty) {
            final name = names[index];
            return {'if_exists': true, 'name': name, 'index': index};
          }
        }
      }
    } catch (e) {
      throw ('Error checking if guest exists: $e');
    }
    return {'if_exists': false, 'name': 'none', 'index': 0};
  }


  //####################################################### ADD NEW GUEST ##############################

  static Future<void> addGuest(String id, String name, String institute) async {
    try {
      final gsheets = GSheets(_credentials);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      final sheet = ss.worksheetByTitle('guest_list');
      if (sheet != null) {
        final DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
        final String formattedDate = formatter.format(DateTime.now());
        final newRow = [id, name, institute, formattedDate];
        await sheet.values.appendRow(newRow);
      } else {
        throw ('Worksheet not found');
      }
    } catch (e) {
      print('Error adding guest: $e');
      throw ('Error adding guest: $e');
    }
  }

  //############################################## Update Activity ######################################

  // Check if guest exists for update
  static Future<Map<String, dynamic>> checkIfGuestExists(String id) async {
    try {
      final gsheets = GSheets(_credentials);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      final sheet = ss.worksheetByTitle('guest_list');
      if (sheet != null) {
        final idColumn = await sheet.values.columnByKey('ID') ?? [];
        if (idColumn.contains(id)) {
          final index = idColumn.indexOf(id);
          final names = await sheet.values.columnByKey('Name') ?? [];
          if (index >= 0 && index < names.length && names[index].isNotEmpty) {
            final name = names[index];
            return {'if_exists': true, 'name': name, 'index': index};
          }
        }
      }
    } catch (e) {
      throw ('Error checking if guest exists: $e');
    }
    return {'if_exists': false, 'name': 'none', 'index': 0};
  }

  // Update QR Data
  static Future<dynamic> updateQRData(
    String qrData,
    String selectedDay,
    String selectedActivity,
    Map<String, dynamic> result,
  ) async {
    try {
      final gsheets = GSheets(_credentials);
      final ss = await gsheets.spreadsheet(_spreadsheetId);
      final sheet = ss.worksheetByTitle(selectedDay);
      if (sheet != null) {
        final int index = result['index'];
        if (result['if_exists']) {
          final List<String>? nameColumn =
              await sheet.values.columnByKey('Name');
          final List<String>? headers = await sheet.values.row(1);
          final int nameIndex = headers?.indexOf('Name') ?? -1;
          final int checkInIndex = headers?.indexOf('Registration Date') ?? -1;
          final int dinnerIndex = headers?.indexOf('Dinner') ?? -1;

          final List<String>? checkInColumn =
              await sheet.values.columnByKey('Registration Date');
          final List<String>? dinnerColumn =
              await sheet.values.columnByKey('Dinner');

          try {
            if (nameColumn == null ||
                nameColumn.isEmpty ||
                index >= nameColumn.length ||
                nameColumn[index] == '') {
              final String name = result['name'];
              await sheet.values
                  .insertValue(name, column: nameIndex + 1, row: index + 2);
            }
            final DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
            final String formattedDate = formatter.format(DateTime.now());

            if (selectedActivity == 'check_in') {
              if (checkInColumn != null &&
                  checkInColumn.length > index &&
                  checkInColumn[index].isNotEmpty) {
                return 'User already checked-in';
              } else {
                await sheet.values.insertValue(formattedDate,
                    column: checkInIndex + 1, row: index + 2);
              }
            } else if (selectedActivity == 'dinner') {
              if (dinnerColumn != null &&
                  dinnerColumn.length > index &&
                  dinnerColumn[index].isNotEmpty) {
                return 'User already completed dinner';
              } else {
                await sheet.values.insertValue(formattedDate,
                    column: dinnerIndex + 1, row: index + 2);
              }
            }
            return 'Updated';
          } catch (e) {
            return e.toString();
          }
        } else {
          final guestListSheet = ss.worksheetByTitle('guest_list');
          final guestIdColumn = await guestListSheet?.values.columnByKey('ID');
          final guestNameColumn =
              await guestListSheet?.values.columnByKey('Name');
          if (guestIdColumn != null && guestNameColumn != null) {
            final guestIndex = guestIdColumn.indexOf(qrData);
            if (guestIndex != -1) {
              final guestName = guestNameColumn[guestIndex];
              final DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm');
              final String formattedDate = formatter.format(DateTime.now());
              final newRow = {
                'ID': qrData,
                'Name': guestName,
                'Registration Date':
                    selectedActivity == 'check_in' ? formattedDate : '',
                'Dinner': selectedActivity == 'dinner' ? formattedDate : '',
              };
              final List<dynamic> newRowList = newRow.values.toList();
              await sheet.values.appendRow(newRowList);
              return 'Updated';
            }
          }
        }
      } else {
        throw ('Worksheet not found');
      }
    } catch (e) {
      print('Error updating QR data: $e');
      return 'Error: $e';
    }
  }


}
