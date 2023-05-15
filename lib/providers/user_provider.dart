import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:twithc_clone/models/users.dart' as models;

class UserProvider extends ChangeNotifier {
  models.User _user = models.User(
    uid: '',
    username: '',
    email: '',
  );
  models.User get user => _user;
  setUser(models.User user) {
    _user = user;
    notifyListeners();
  }
}
