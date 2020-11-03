import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_space/models/myspace.dart';
import 'package:provider/provider.dart';
import 'package:my_space/screens/home/myspace_tile.dart';

class MySpaceList extends StatefulWidget {
  @override
  _MySpaceListState createState() => _MySpaceListState();
}

class _MySpaceListState extends State<MySpaceList> {
  @override
  Widget build(BuildContext context) {

    final myspaces= Provider.of<List<MySpace>>(context) ?? [];

    return  ListView.builder(
      itemCount: myspaces.length ,
      itemBuilder: (context, index){
        return MySpaceTile(myspace: myspaces[index]);
      }
    );
  }
}