import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_space/models/myspace.dart';
import 'package:my_space/screens/home/profile.dart';
import 'package:my_space/screens/home/settings_form.dart';
import 'package:my_space/services/auth.dart';
import 'package:my_space/services/database.dart';
import 'package:provider/provider.dart';
import 'myspace_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingForm(),
        );
      });
    }

    return StreamProvider<List<MySpace>>.value(
      value: DatabaseService().myspace,
      child: Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Colors.purple,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person ),
            label: Text('Profile'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileForm()),
              );
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async{
              await _auth.signOut();
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
            onPressed: () => _showSettingsPanel(),
          ) 
        ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/LightBg.png'),
              fit: BoxFit.cover,
            )
          ),
          child: MySpaceList()
      ),
    ));
  }
}