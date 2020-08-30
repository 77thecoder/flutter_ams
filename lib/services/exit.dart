import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppService {
  static Future<bool> exit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user.isAuth');
    prefs.remove('user.login');
    prefs.remove('user.tn');
    prefs.remove('user.fio');
    prefs.remove('user.email');
    prefs.remove('user.position');
    prefs.remove('user.department');
    prefs.remove('userInfo');
    return true;
  }
}