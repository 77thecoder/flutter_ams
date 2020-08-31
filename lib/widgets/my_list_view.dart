import 'package:flutter/material.dart';
import 'package:nvbs_ams/models/user_info.dart';

class MyListView extends StatelessWidget {
  UserInfo userInfo;

  MyListView({this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 0, maxHeight: 400),
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              leading: Icon(Icons.work_outline_outlined),
              title: Text(userInfo.users.first.position.name,),
              subtitle: Text(userInfo.users.first.organizationalStructure.name,),
            ),
            ListTile(
              leading: Icon(Icons.home_work_outlined),
              title: Text(userInfo.users.first.department[0].name,),
            ),
            ListTile(
              leading: Icon(Icons.phone_android),
              title: Text(userInfo.users.first.phone),
            ),
            ListTile(
              leading: Icon(Icons.email_outlined),
              title: Text(userInfo.users.first.eMail),
            ),
            ListTile(
              leading: Icon(Icons.room_outlined),
              title: Text(userInfo.users.first.city),
              trailing: Icon(
                Icons.open_in_new,
                size: 17,
              ),
              onTap: () {
                print('открываем страницу с картой');
              },
            ),
            (userInfo.subordinates.length > 0)
              ? ListTile(
                leading: Icon(Icons.people_outlined),
                title: Text('Подчиненные'),
                trailing: Icon(
                  Icons.open_in_new,
                  size: 17,
                ),
                onTap: () {
                  print('открываем страницу с подчиненными');
                },
              )
              : Text(''),
          ],
        ).toList(),
      )
    );
  }
}
