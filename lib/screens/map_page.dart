import 'package:flutter/material.dart';

class MapOffice extends StatefulWidget {
  @override
  _MapOfficeState createState() => _MapOfficeState();
}

class _MapOfficeState extends State<MapOffice> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Где мой офис?'),
        backgroundColor: Colors.red,
      ),
      body: _mapPage(),
    );
  }
}

class _mapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Map'),
    );
  }
}

