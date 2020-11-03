import 'package:flutter/material.dart';
import 'package:my_space/models/myspace.dart';

class MySpaceTile  extends StatelessWidget {

  final MySpace myspace;
  MySpaceTile({this.myspace});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0) ,
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0) ,
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.limeAccent,
            ),
          title: Text(myspace.name),
          subtitle: Text('Age : ${myspace.age}')
          ),
        ),
    );
  }
}