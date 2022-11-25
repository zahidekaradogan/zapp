import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zapp/common_widget/social_log_in_button.dart';
import 'package:zapp/model/user_model.dart';
import 'package:zapp/viewmodel/user_model.dart';


enum FormType { Register, LogIn }

class EmailveSifreLoginPage extends StatefulWidget {
  @override
  _EmailveSifreLoginPageState createState() => _EmailveSifreLoginPageState();
}

class _EmailveSifreLoginPageState extends State<EmailveSifreLoginPage> {
  String _email, _sifre;
  String _buttonText, _linkText;
  var _formType = FormType.LogIn;
  final _formKey = GlobalKey<
      FormState>();                                                             //formu kullanabilmek için bir form key oluşturduk.

  void _formSubmit(BuildContext context) async {
    _formKey.currentState.save();
    //debugPrint("email :" + _email + " şifre:" + _sifre);
    final _userModel = Provider.of<UserModel>(context);

    if (_formType == FormType.LogIn) {
      User _girisYapanUser =
          await _userModel.signInWithEmailandPassword(_email, _sifre);
      if (_girisYapanUser != null)
        print("Oturum açan user id:" +
            _girisYapanUser.userID
                .toString());                                                   //eğer giriş yapan user null a eşit değil ise bu bilgileri yazdır.
    } else {
      User _olusturulanUser =
          await _userModel.createUserWithEmailandPassword(_email, _sifre);
      if (_olusturulanUser != null)
        print("Oturum açan user id:" + _olusturulanUser.userID.toString());
    }
  }

  void _degistir() {
    setState(() {
      _formType = _formType == FormType.LogIn
          ? FormType.Register
          : FormType.LogIn;                                                     //form tipini devamlı olarak değiştirerek set eder.
    });
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.LogIn
        ? "Giriş Yap"
        : "Kayıt Ol";                                                           //eğer form tipi login ise giriş yap değil ise kayıt ol
    _linkText = _formType == FormType.LogIn
        ? "Hesabınız Yok Mu? Kayıt Olun"
        : "Hesabınız Var Mı? Giriş Yapın";

    final _userModel = Provider.of<UserModel>(context);

    if(_userModel.user != null){
      Future.delayed(Duration(milliseconds: 10));
      Navigator.of(context).pop();                                              //user modeldeki user null a eşit değilse diyalog sayfası kapatılır.
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Giriş / Kayıt"),
          actions: <Widget>[],
        ),
        body: _userModel.state == ViewState.Idle
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: "zahide@zahide.com",
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            errorText: _userModel.emailHataMesaji != null ? _userModel.emailHataMesaji :null,
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Email',
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String girilenEmail) {
                            _email = girilenEmail;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          initialValue: "password",
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: _userModel.sifreHataMesaji != null ? _userModel.sifreHataMesaji: null,
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Şifre',
                            labelText: 'şifre',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String girilenSifre) {
                            _sifre = girilenSifre;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SocialLoginButton(
                          butonText: _buttonText,
                          butonColor: Theme.of(context).primaryColor,
                          radius: 18,
                          onPressed: () => _formSubmit(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                            onPressed: () => _degistir(),
                            child: Text(_linkText))
                      ],
                    ),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()
        ));
  }
}
