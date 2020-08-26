import 'dart:convert';

import 'package:http/http.dart' as http;

class AMSRequest {
  Future<bool> send(url) async {
    final String _amsLogin = 'EXCHANGE';
    final String _amsPassword = 'J,vty82';
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_amsLogin:$_amsPassword'));

    http.Response response;

    try {
      response = await http.get(url, headers: <String, String>{'authorization': basicAuth});
    } catch (error) {
      return Future<bool>.value(false);
    }

    print('response ' + response.body.toString());
  }

  static Future<bool> getSubordinates() async {
    http.Response response;


    return Future<bool>.value(true);
  }

  Future<bool> getInfoUser() async {
    bool s = await send('https://itil.nvbs.ru/AMS_NVBS/hs/UserAccess/GetUserData/AMUR?Variant=0&Login=DKostin&TotalInformation=1&Subordinates=1');
    return Future<bool>.value(true);
  }
}