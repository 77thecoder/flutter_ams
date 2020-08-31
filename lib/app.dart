import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nvbs_ams/screens/landing_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

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
      home: LandingPage(),
    );
  }
}