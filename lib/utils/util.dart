import 'package:flutter/material.dart';
// import 'package:google_auth/screens/home.dart';
import 'package:appwrite/appwrite.dart';

class Appconstants {
  static const String endpoint = "<endpoint or hostname>";
  static const String projectid = "<project ID>";
}

class AppProvider extends ChangeNotifier {
  Client client = Client();
  late Account account;
  late bool _isLoggedIn;
  bool get isLoggedIn => _isLoggedIn;
  AppProvider() {
    _isLoggedIn = true;
    initialize();
  }
  initialize() {
    client
      ..setProject(Appconstants.projectid)
      ..setEndpoint(Appconstants.endpoint);
    account = Account(client);
    checkLogin();
  }
  checkLogin() async {
    try {
      await account.get();
    } catch (_) {
      _isLoggedIn = false;
      notifyListeners();
    }
  }
  socialSignIn(String provider, context) async {
    await account
        .createOAuth2Session(
      provider: provider,
      success: "",
      failure: "",
    )
        .then((response) {
      _isLoggedIn = true;
      notifyListeners();
    }).catchError((e) {
      _isLoggedIn = false;
      notifyListeners();
    });
  }
}