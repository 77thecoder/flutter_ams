import 'package:flutter/material.dart';
import 'package:nvbs_ams/screens/home_page.dart';
import 'package:nvbs_ams/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  Future<String> _initialRoute() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('user.isAuth') ? '/home' : '/';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'НВБС АМС',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomePage()
      },
      initialRoute: _initialRoute().toString(),
    );
  }
}