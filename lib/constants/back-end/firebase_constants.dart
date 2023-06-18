import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final fireAuth = FirebaseAuth.instance;
final firePostsCollec = FirebaseFirestore.instance.collection("posts");
final fireUsersCollec = FirebaseFirestore.instance.collection("users");

class Usr {
  final User? _user = FirebaseAuth.instance.currentUser;
  User? get crntUsr => _user;
}
