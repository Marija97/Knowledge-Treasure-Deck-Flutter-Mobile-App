import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';

String deploymentID = "<Your-deploymentID>";
String sheetID = "<Your-google-sheet-ID>"; // can be extracted from your google sheets url.

Future<Map> triggerWebAPP({required Map body}) async {
  Map dataDict = {};
  Uri URL =
  Uri.parse("https://script.google.com/macros/s/${deploymentID}/exec");
  try {
    await http.post(URL, body: body).then((response) async {
      if ([200, 201].contains(response.statusCode)) {
        dataDict = jsonDecode(response.body);
      }
      if (response.statusCode == 302) {
        String redirectedUrl = response.headers['location'] ?? "";
        if (redirectedUrl.isNotEmpty) {
          Uri url = Uri.parse(redirectedUrl);
          await http.get(url).then((response) {

            if ([200, 201].contains(response.statusCode)) {

              dataDict = jsonDecode(response.body);
            }
          });
        }
      } else {
        print("Other StatusCOde: ${response.statusCode}");
      }
    });
  } catch (e) {
    print("FAILED: $e");
  }

  return dataDict;
}

Future<Map> getSheetsData({required String action}) async {
  Map body = {"sheetID": sheetID, "action": action};

  Map dataDict = await triggerWebAPP(body: body);

  return dataDict;
}