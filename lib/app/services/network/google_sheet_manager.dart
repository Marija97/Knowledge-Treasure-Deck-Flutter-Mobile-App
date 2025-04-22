import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';

class Columns {
  // currently
  static const question = 1;
  static const hint = 2;
  static const answer = 3;
  static const explanation = 4;
  static const example = 5;
  static const status = 6;

  // in the future
  // static const question = 1;
  // static const contextCro = 2;
  // static const hint = 3;
  // static const answer = 4;
  // static const explanation = 5;
  // static const contextGe = 6;
  // static const example = 7;
  // static const isToBeKept = 8;
}


class GoogleSheetManager {
  static final _deploymentID =
      dotenv.env['GOOGLE_SHEET_PROJECT_DEPLOYMENT_ID']!;

  static final _sheetID = dotenv.env['GOOGLE_SHEET_DATASET_ID']!;

  static final _webAppPath =
      'https://script.google.com/macros/s/$_deploymentID/exec';

  static final _sheetTabName = 'test';

  Future<Map<String, dynamic>> _triggerWebAPP(Map<String, dynamic> body) async {
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

  Future<bool> _write({
    required int row,
    required List data,
    int startingColumn = 1,
  }) async {
    final parameters = {
      'sheetID': _sheetID,
      'action': 'write',
      'tab': _sheetTabName,
      'row': row.toString(),
      'data': data.toString(),
      'numRows': 1.toString(), // default
      'startingColumn': startingColumn.toString(),
    };
    final result = await _triggerWebAPP(parameters);
    if(result['status'] == 'success') return true;
    return false;
  }

  Future<bool> markStatus({required int row, required String status}) async {
    return _write(row: row, data: [status], startingColumn: Columns.status);
  }

}
