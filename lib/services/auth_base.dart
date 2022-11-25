import 'dart:async';
import 'package:zapp/model/user_model.dart';

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<bool> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> signInWithEmailandPassword(String email, String sifre);
  Future<User> createUserWithEmailandPassword(String email, String sifre);
}
