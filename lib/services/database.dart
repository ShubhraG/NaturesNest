import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_space/models/myspace.dart';
import 'package:my_space/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid}); 

  //collection reference
  final CollectionReference myspaceCollection = Firestore.instance.collection('myspace');
  
  
  Future updateUserData(String name, int age, String location) async {
    return await myspaceCollection.document(uid).setData({
      'name': name,
      'age': age,
      'location': location
    });
  }

  //List from a snapshot
  List<MySpace> _myspacelistFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return MySpace(
        name: doc.data['name'] ?? '',
        age: doc.data['age'] ?? 0,
        location: doc.data['location'] ?? ''
      );
    }).toList();
  }

//User Data from snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid: uid,
    name: snapshot.data["name"],
    age: snapshot.data["age"],
    location: snapshot.data["location"],
  );
}


//Get db stream
Stream<List<MySpace>> get myspace{
  return myspaceCollection.snapshots()
  .map(_myspacelistFromSnapshot);
}

//get user document stream
Stream<UserData> get userData{
  return myspaceCollection.document(uid).snapshots()
  .map(_userDataFromSnapshot);
}

}