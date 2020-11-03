import 'package:flutter/material.dart';
import 'package:my_space/services/auth.dart';
import 'package:my_space/shared/constants.dart';
import 'package:my_space/shared/loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth= AuthService();
  final _formKey= GlobalKey<FormState>();
  bool loading = false;

  //Text Field State
  String email = '';
  String password = '';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
        title: Text('Welcome to Nature''s Nest'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            }
          )
        ],
      ),
      body: Container(
         decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/lotus.png'),
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
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(()=> email = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length<6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val){
                   setState(()=> password = val);
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                   if(_formKey.currentState.validate()){
                     setState(() => loading = true);
                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                     if(result == null){
                      setState(() {
                        error = 'Could not sign in with those credentials';
                        loading = false;
                      });
                     }
                  }
                },
                ),
                   Container(
                    alignment: Alignment(0.0,0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    child: InkWell(
                      child: Text('Forgot Password',
                      style: TextStyle(
                          color: Colors.white,
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