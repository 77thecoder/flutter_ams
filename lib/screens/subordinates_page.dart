import 'package:flutter/material.dart';

class SubordinatesPage extends StatefulWidget {
  @override
  _SubordinatesPageState createState() => _SubordinatesPageState();
}

class _SubordinatesPageState extends State<SubordinatesPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Мои подчиненные'),
        backgroundColor: Colors.red,
      ),
      body: _subordinatesList(),
    );
  }
}

class _subordinatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Список подчиненных'),
    );
  }
}

