import 'package:chithi/constants/back-end/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateStreamProvider = StreamProvider<User?>((ref) {
  return fireAuth.authStateChanges();
});
