import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';

class GoogleSheetManager {
  static final _deploymentID =
      dotenv.env['GOOGLE_SHEET_PROJECT_DEPLOYMENT_ID']!;

  static final _sheetID = dotenv.env['GOOGLE_SHEET_DATASET_ID']!;

  static final _webAppPath =
      'https://script.google.com/macros/s/$_deploymentID/exec';
  
  static final _sheetTabName = 'test';

  Future<Map<String, dynamic>> _triggerWebAPP(Map<String, String> body) async {
    Map<String, dynamic> dataDict = {};
    final webAppURL = Uri.parse(_webAppPath);
    try {
      await http.post(webAppURL, body: body).then((response) async {
        if ([200, 201].contains(response.statusCode)) {
          dataDict = jsonDecode(response.body);
        }
        if (response.statusCode == 302) {
          String redirectedUrl = response.headers['location'] ?? '';
          if (redirectedUrl.isNotEmpty) {
            Uri url = Uri.parse(redirectedUrl);
            await http.get(url).then((response) {
              if ([200, 201].contains(response.statusCode)) {
                dataDict = jsonDecode(response.body);
              }
            });
          }
        } else {
          print('Other StatusCOde: ${response.statusCode}');
        }
      });
    } catch (e) {
      print('FAILED: $e');
    }

    return dataDict;
  }

  Future<Map<String, dynamic>?> testReadData() async {
    final body = {'sheetID': _sheetID, 'action': 'read', 'tab': _sheetTabName};
    return await _triggerWebAPP(body);
  }
}
