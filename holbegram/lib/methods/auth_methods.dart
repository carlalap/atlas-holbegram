import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:holbegram/models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login method
  Future<String> login(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill all the fields';
    }
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  // Sign up method
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return 'Please fill all the fields';
    }
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        Users newUser = Users(
          uid: user.uid,
          email: email,
          username: username,
          bio: '',
          photoUrl: '',
          followers: [],
          following: [],
          posts: [],
          saved: [],
          searchKey: username[0].toUpperCase(),
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(newUser.toJson());
        return 'success';
      } else {
        return 'Error creating user';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Users?> getUserDetails() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (snapshot != null) {
          final user = Users.fromSnap(snapshot);
          return user;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
