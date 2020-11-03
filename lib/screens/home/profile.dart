import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_space/models/myspace.dart';
import 'package:my_space/screens/home/profile.dart';
import 'package:my_space/screens/home/settings_form.dart';
import 'package:my_space/services/auth.dart';
import 'package:my_space/services/database.dart';
import 'package:provider/provider.dart';
import 'myspace_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm>{

  final AuthService _auth = AuthService();
  File _image;

  @override
  Widget build(BuildContext context) {

    Future getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image= image;
      });
    }

   Future uploadPic(BuildContext context) async{
     String fileName = basename(_image.path);
     StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
     StorageUploadTask uploadTask= firebaseStorageRef.putFile(_image);
     StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;
     setState(() {
       print("Profile picture uploaded");
       Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
     });
   }

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
        title: Text('Profile'),
        backgroundColor: Colors.purple,
        elevation: 0.0,
        actions: <Widget>[
         
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.purple,
                  child: ClipOval(
                    child: SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: (_image!=null)?Image.file(_image, fit: BoxFit.fill)
                      :Image.network(
                            "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                            fit: BoxFit.fill),
                          ), 
                    ),
                    
                    )
                ),
                Padding(
                padding: EdgeInsets.only(top:60.0),
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.camera,
                      size: 30.0,
                    ),
                    onPressed: (){
                        getImage();
                    },
                    ),
                )
              ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Name: ',
                          style: TextStyle(color: Colors.black,fontSize: 18.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Shubhra G',
                          style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),
                          ),
                        ),

                      ],)
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Age: ',
                          style: TextStyle(color: Colors.black,fontSize: 18.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('10',
                          style: TextStyle(color: Colors.black,fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),

                      ],)
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),

               SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Location: ',
                          style: TextStyle(color: Colors.black,fontSize: 18.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Pune',
                          style: TextStyle(color: Colors.black,fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),

                      ],)
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              
              
               SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Email: shubhrag@gmail.com ',
                          style: TextStyle(color: Colors.black,fontSize: 18.0),
                          ),
                        ),

                      ],)
                    ),
                  ),
                  
                ],
              ),

               SizedBox(height: 20.0),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.pink,
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                   RaisedButton(
                    color: Colors.pink,
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  )

                ]
              ),
             
            ],
          ),
          //SizedBox(height: 20.0,),

      ),
    ));
  }
}

