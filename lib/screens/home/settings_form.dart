import 'package:flutter/material.dart';
import 'package:my_space/models/user.dart';
import 'package:my_space/services/database.dart';
import 'package:my_space/shared/constants.dart';
import 'package:my_space/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {

  final _formKey= GlobalKey<FormState>();
  final List<String> hobbies = ['a', 'b','c'];

  //form values
  String _currentName;
  int _currentAge;
  String _currentlocation;
  String _currenthobby;
  


  @override
  Widget build(BuildContext context) {
    final user=  Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

        UserData userData = snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update your profile settings.',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: userData.name,
                decoration: textInputDecoration,
                validator: (val)=> val.isEmpty? 'Please enter a name' : null,
                onChanged: (val)=> setState(() => _currentName= val),
              ),
              SizedBox(height: 20.0),
              //dropdown
              DropdownButtonFormField(
                 decoration: textInputDecoration,
                value: _currenthobby ?? 'a',
                items: hobbies.map((hobby){
                  return DropdownMenuItem(
                    value: hobby,
                    child: Text('$hobby'),
                  );
                }).toList(),
                onChanged: (val)=> setState(() => _currenthobby= val),
              ),
              //slider
              RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentName?? userData.name, 
                          _currentAge?? userData.age, 
                          _currentlocation?? userData.location
                        );
                        Navigator.pop(context);
                      }
                    },
              )

            ],
          ),
        );
        }
        else{
          return Loading();
        }
      }
    );
  }
}