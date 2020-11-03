import 'package:flutter/material.dart';
import 'package:my_space/services/auth.dart';
import 'package:my_space/shared/constants.dart';
import 'package:my_space/shared/loading.dart';

class ChangePassword extends StatefulWidget {

  final Function toggleView;
  ChangePassword({this.toggleView});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override

   final AuthService _auth= AuthService();
   final _formKey= GlobalKey<FormState>();
   bool loading = false;

  //Text Field State
  String oldpassword = '';
  String newpassword1 = '';
  String newpassword2 = '';
  String error='';

  Widget build(BuildContext context) {
   return loading ? Loading() : Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
        title: Text('Change Password'),
         actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Login'),
            onPressed: () {
              widget.toggleView();
            }
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
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Old Password'),
                validator: (val) => val.isEmpty ? 'Enter old password' : null,
                onChanged: (val){
                  setState(()=> oldpassword = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'New Password'),
                obscureText: true,
                validator: (val) => val.length<6 ? 'Enter new password' : null,
                onChanged: (val){
                   setState(()=> newpassword1 = val);
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                 /* if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                   dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                   if(result == null){
                     setState(() {
                        error = 'Please supply a valid email';
                        loading = false;
                      });
                   }
                  }*/
                },
                ),
                 Container(
                    alignment: Alignment(0.0,0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                      child: Text('Change Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline
                      ))
                    )
                  ),
                Text(
                  error, 
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
               
                ],
 
            
            ),
        )
      
        ),
    );
 

  }
}