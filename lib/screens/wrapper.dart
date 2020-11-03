import 'package:flutter/material.dart';
import 'package:my_space/models/user.dart';
import 'package:my_space/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:my_space/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    //return Home();
    final user=  Provider.of<User>(context);
    //print(user);
    if(user== null){
      return Authenticate();
    }
    else
    {
      return Home();
    }
    
  }
}