import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zapp/app/sign_in/sign_in_page.dart';
import 'package:zapp/viewmodel/user_model.dart';

import '../home_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /*önce user modeli elde edlip state' e bakılır daha sonra state ilgili adımlara göre değitirilebilir.
     * ne zaman ki butona tıklanır önce busy yapılır sonra işlem bitince tekradan idle' a çekilir.
     * user var mı yok mu onun kontrolü yapılır.
     * buradaki iki if'den biri user'ı kontrol eder diğeri state'i kontrol eder.
     * */

    final _userModel = Provider.of<UserModel>(context);
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return SignInPage();
      } else {
        return HomePage(user: _userModel.user);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
