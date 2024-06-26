import 'package:flutter/foundation.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/user.dart';

class UserProvider extends ChangeNotifier {
  final AuthMethode _authMethode = AuthMethode();

  Users? _user;

  Users? get user => _user;

  Future<void> refreshUser() async {
    final user = await _authMethode.getUserDetails();
    _user = user;
    print(_user);
    notifyListeners();
  }
}
