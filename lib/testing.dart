import 'package:gsheets/gsheets.dart';

void main() async {
  const _credentials = {
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

  const _spreadsheetId = '1qglftjbYoytykTbP-FXiGpF1aHR9dSiVJiVn4UeNY0M';

  final gsheets = GSheets(_credentials);
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  final sheet = ss.worksheetByTitle('guest_list');

  if (sheet != null) {
    print('Connected to Google Sheet successfully');
    final names = await sheet.values.columnByKey('Name') ?? [];
    final ids = await sheet.values.columnByKey('ID') ?? [];
    print('Names: $names');
    print('IDs: $ids');
  } else {
    print('Worksheet not found');
  }
}
