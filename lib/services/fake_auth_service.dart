import 'dart:async';

import 'package:zapp/model/user_model.dart';

import 'auth_base.dart';

class FakeAuthenticationService implements AuthBase {
  String userID = "1213212321321321321321";

  @override
  Future<User> currentUser() async {
    return await Future.value(User(userID: userID, email:"fakeuser@fake.com" ));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<User> signInAnonymously() async {
    return await Future.delayed(
        Duration(seconds: 2),
            () => User(userID: userID,email:"fakeuser@fake.com"));
  }

  @override
  Future<User> signInWithGoogle() async{
    return await Future.delayed(
        Duration(seconds: 2),
            () =>
            User(userID: "google_user_id_123456",email:"fakeuser@fake.com" ));
  }



  @override
  Future<User> createUserWithEmailandPassword(String email, String sifre) async {
    return await Future.delayed(
        Duration(seconds: 2),
            () =>
            User(userID: "created_user_id_123456" ,email:"fakeuser@fake.com"));
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    return await Future.delayed(
        Duration(seconds: 2),
            () =>
            User(userID: "signIn_user_id_123456",email:"fakeuser@fake.com" ));
  }
}
