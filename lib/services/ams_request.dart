import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:nvbs_ams/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AMSRequest {
  Future<bool> sendUser(url) async {
    final String _amsLogin = 'login';
    final String _amsPassword = 'password';
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
    pref.setString('userInfo', json.encode(userInfo));
    return Future<bool>.value(true);
  }

  Future<bool> getInfoUser(String login) async {
    bool result = await sendUser('url');
    return Future<bool>.value(result);
  }

  Future send(url) async {
    final String _amsLogin = 'login';
    final String _amsPassword = 'password';
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$_amsLogin:$_amsPassword'));

    http.Response response;

    try {
      response = await http.get(url, headers: <String, String>{'authorization': basicAuth});
    } catch (error) {
      return Future<bool>.value(false);
    }

    return response;
  }


  Future<String> getImageUser(String ID) async {
    http.Response response = await send('url');
    String _base64 = base64.encode(response.bodyBytes);
    return _base64;
  }
}
