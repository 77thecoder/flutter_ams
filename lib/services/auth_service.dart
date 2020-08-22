import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nvbs_ams/models/user.dart';

class AuthService {
  final String API_URL = 'http://api.nvbs.ru/api';

  Future<String> authAD(String login, String password) async {
    print('account $login $password');
    http.Response response;

    try {
      response = await http.post(
        API_URL + '/ad/auth',
        body: {'login': login, 'password': password},
      );
    } catch (error) {
      return error;
    }

    Map<String, dynamic> user = jsonDecode(response.body);
    print(user);
//    user['isAuth'] = user['isAuth'].toString();
    if (response.statusCode == 200) {
      User.fromJson(json.decode(response.body));
    }

    return response.body;
  }
}