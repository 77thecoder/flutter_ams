import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nvbs_ams/services/ams_request.dart';

class Avatar extends StatefulWidget {
  final String idUser;

  const Avatar({this.idUser, Key key}) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  String image;
  String _base64;

  @override
  void initState() {
    _getImageUser(widget.idUser);
  }

  Future<String> _getImageUser(_idIser) async {
    AMSRequest ams = new AMSRequest();
    String imageBase64 = await ams.getImageUser(_idIser);

    setState(() {
      _base64 = imageBase64;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_base64 == null)
      return new Container();

    Uint8List bytes = base64.decode(_base64);

    return ClipRRect(

      borderRadius: BorderRadius.circular(50),
      child: Image.memory(bytes),
    );
    // return Image.memory(bytes);
  }
}