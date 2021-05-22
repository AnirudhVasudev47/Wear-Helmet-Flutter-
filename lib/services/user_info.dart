import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wear_helmet/model/user_model.dart';

class UserInfo{
  
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('users');
  
  List<UserModel> user = [];
  


}