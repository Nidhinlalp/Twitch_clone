import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twithc_clone/models/users.dart' as models;
import 'package:twithc_clone/providers/user_provider.dart';
import 'package:twithc_clone/utils/utils.dart';

class AuthMethods {
  final _userRef = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;
  Future<bool> signUpUser(
    BuildContext context,
    String email,
    String username,
    String password,
  ) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (cred.user != null) {
        models.User user = models.User(
          uid: cred.user!.uid,
          username: username.trim(),
          email: email.trim(),
        );
        await _userRef.doc(cred.user!.uid).set(user.toMap());
        if (context.mounted) {
          Provider.of<UserProvider>(context, listen: false).setUser(user);
        }

        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }
    return res;
  }
}
