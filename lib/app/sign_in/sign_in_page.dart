import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zapp/common_widget/social_log_in_button.dart';
import 'package:zapp/model/user_model.dart';
import 'package:zapp/viewmodel/user_model.dart';
import '../email_sifre_giris_ve_kayit.dart';

class SignInPage extends StatelessWidget {
  void _misafirGirisi(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    User _user = await _userModel.signInAnonymously();
    print("Oturum açan user id: " + _user.userID.toString());
  }

  void _googleIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    User _user = await _userModel.signInWithGoogle();
    if (_user != null) print("Oturum açan user id: " + _user.userID.toString());
  }

  void _facebookIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    User _user = await _userModel.signInWithFacebook();
    if (_user != null) print("Oturum açan user id: " + _user.userID.toString());
  }

  void _emailVeSifreGiris(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailveSifreLoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zapp"),
        elevation: 0,
      ),
      backgroundColor: Color.fromRGBO(254, 250, 224, 1),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Oturum Açın',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(40, 54, 24, 1)),
            ),
            SizedBox(
              height: 8,
            ),
            SocialLoginButton(
              butonText: "Gmail ile Giriş Yap",
              butonColor: Colors.white,
              textColor: Colors.black87,
              butonIcon: Image.asset("images/google-logo.png"),
              onPressed: () => _googleIleGiris(context),
            ),
            SocialLoginButton(
              butonText: "Facebook ile Giriş Yap",
              butonColor: Color(0xFF334D92),
              butonIcon: Image.asset("images/facebook-logo.png"),
              onPressed: () => _facebookIleGiris(context),
            ),
            SocialLoginButton(
              butonText: "Email ve şifre ile Giriş Yap",
              butonColor: Color.fromRGBO(96, 108, 56, 1),
              butonIcon: Icon(
                Icons.email,
                size: 32,
                color: Colors.white,
              ),
              onPressed: () => _emailVeSifreGiris(context),
            ),
            SocialLoginButton(
              butonText: "Misafir Girişi",
              butonIcon: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
                size: 32,
              ),
              butonColor: Color.fromRGBO(96, 108, 56, 1),
              onPressed: () => _misafirGirisi(context),
            ),
          ],
        ),
      ),
    );
  }
}
