import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nvbs_ams/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    UserInfo userInfo = UserInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('userInfo ' + json.encode(userInfo));
    pref.setString('userInfo', json.encode(userInfo));
    return Future<bool>.value(true);
  }

  Future<bool> getInfoUser() async {
    bool result = await send('https://itil.nvbs.ru/AMS_NVBS/hs/UserAccess/GetUserData/AMUR?Variant=0&Login=DKostin&TotalInformation=1&Subordinates=1');
    return Future<bool>.value(result);
  }
}