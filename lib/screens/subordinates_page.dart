import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvbs_ams/models/user_info.dart';
import 'package:nvbs_ams/screens/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubordinatesPage extends StatefulWidget {
  @override
  _SubordinatesPageState createState() => _SubordinatesPageState();
}

class _SubordinatesPageState extends State<SubordinatesPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  UserInfo _userInfo;
  UserInfo _UserInfo;
  List<Subordinate> _subordinates;
  List<Subordinate> _Subordinates;

  @override
  void initState() {
    _getUserInfo();
  }

  void _getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String jsonData = pref.get('userInfo');
    _userInfo = UserInfo.fromJson(json.decode(jsonData));
    _subordinates = _userInfo.subordinates;

    setState(() {
      _UserInfo = _userInfo;
      _Subordinates = _subordinates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Мои подчиненные'),
        backgroundColor: Colors.red,
      ),
      body: _Subordinates == null ? Text('Loading') : _subordinatesList(_Subordinates),
    );
  }
}

class _subordinatesList extends StatelessWidget {
  List<Subordinate> _subordinates;
  UserInfo _userInfo;

  _subordinatesList(this._subordinates);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _subordinates.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          // height: 30,
          child: ListTile(
            title: Text(_subordinates[index].description),
            trailing: Icon(
              Icons.open_in_new,
              size: 17,
            ),
            onTap: () {
              print('Щелк по подчиненному');
            },
          )
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

