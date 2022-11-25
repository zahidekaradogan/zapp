//BU DOSYADA WİDGETLARLA ALAKALI BİR BİLGİ YOK METODLAR VAR.

// Gelen veriye göre arayüzün güncellenmesini sağlayan yapı provider' lardır.
//Yani set state kullanımından kurtarır.
//Hangi durumlarda arayüzün güncellenmesi gerektiği dşünülmelidir.
//burada business logic ile widget ları birbirinden ayırıyoruz(katmanlı mimari)


import 'package:flutter/material.dart';
import 'package:zapp/model/user_model.dart';
import 'package:zapp/repository/user_repository.dart';
import 'package:zapp/services/auth_base.dart';
import '../locate.dart';

enum ViewState {
  Idle,
  Busy
} //o anki view ın durumları ya boşta olabilir y da internetten veri çekiyo olabilir.

class UserModel with ChangeNotifier implements AuthBase {
  //bu sınıf isteklerin repositorye yollandığı yerdir.

  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  User _user;
  String emailHataMesaji;
  String sifreHataMesaji;

  User get user => _user;

  ViewState get state => _state;

  /*
  sağ tık ile getter ve setter seçip state için bu yapıyı oluşturttuk. sonradan setin içine notifylistener'ı ekledik.
  ıdle ve busy değişimini yaptığımızda kodda set state metodunu çalıştırmak için.
  * */

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  } //user model den nesne üretildiğinde current user metodu çağırılır.

  @override
  Future<User> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState
          .Idle; //current user alındıktan sonra busy değil artık ıdle olur.Finally ile set state durumu günceller.Oturum açmak isteyince user dolu mu null mı kontrol edilebilir.
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymously();
      return _user;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithGoogle() async{
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      if (_user != null)
        return _user;
      else
        return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithFacebook() async{
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithFacebook();
      if (_user != null)
        return _user;
      else {
        return null;
      }
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> createUserWithEmailandPassword(String email, String sifre) async {
    try {
      if(_emailSifreKontrol(email, sifre)){
        state = ViewState.Busy;
        _user = await _userRepository.createUserWithEmailandPassword(email, sifre);
        return _user;
      }else return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    try {
      if(_emailSifreKontrol(email, sifre)){
        state = ViewState.Busy;
        _user = await _userRepository.signInWithEmailandPassword(email, sifre);
        return _user;
      }else return null;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  bool _emailSifreKontrol(String email, String sifre){
    var sonuc = true;
    if( sifre.length<6 ){
      sifreHataMesaji = "En az 6 karakter olmalı";
      sonuc = false;
    } else sifreHataMesaji = null;
    if(!email.contains('@')){
      emailHataMesaji = "Geçersiz email adresi";
      sonuc = false;
    } else emailHataMesaji = null;
    return sonuc;
  }

}
