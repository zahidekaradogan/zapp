import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zapp/model/user_model.dart';
import 'auth_base.dart';

class FirebaseAuthService implements AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> currentUser() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _userFromFirebase(user);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return User(userID: user.uid, email: user.email);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();


      await _firebaseAuth.signOut();
      return true;

    } catch (e) {
      print("SIGN OUT HATA" + e.toString());
      return false;
    }
  }

  @override
  Future<User> signInAnonymously() async {
    try {
      AuthResult sonuc = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("Anonim giriş hatası" + e.toString());
    }
    return null;
  }

  @override
  Future<User> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        AuthResult sonuc = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));
        FirebaseUser _user = sonuc.user;
        return _userFromFirebase(_user);                                        // burada firebase user ı kullanarak kendi oluşturduğumuz user modelinde bir nesneyi geriye döndürecek.
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


  @override
  Future<User> createUserWithEmailandPassword(String email, String sifre) async{
    try {
      AuthResult sonuc = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: sifre);
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("Anonim giriş hatası" + e.toString());
    }
    return null;
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre)async {
    try {
      AuthResult sonuc = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: sifre);
      return _userFromFirebase(sonuc.user);
    } catch (e) {
      print("Anonim giriş hatası" + e.toString());
    }
    return null;
  }
}
