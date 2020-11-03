import 'package:flutter/material.dart';
import 'package:my_space/models/user.dart';
import 'package:my_space/screens/wrapper.dart';
import 'package:my_space/services/auth.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child:  MaterialApp(
        home: Wrapper(),
      )
    );
  }
}

