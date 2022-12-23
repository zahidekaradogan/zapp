import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String userID;
  String email;
  String userName;
  String profilURL;
  DateTime createdAt;
  DateTime updatedAt;
  int seviye;

  User({@required this.userID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "email": email,
      "userName": userName ?? '',
      "profilURL": profilURL ??
          'https://1.bp.blogspot.com/-z7J9PGGtUAY/X42UXKAN-vI/AAAAAAAAAeg/woJcoqqq4d0u3D9VIjxwcqB4rvQ0NnNRwCK4BGAYYCw/s150/IMG_3133.JPG',
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
      "updatedAt": updatedAt ?? FieldValue.serverTimestamp(),
      "seviye": seviye ?? 1,
    };
  }

  /*
  burada verileri okumak için bir isimlendirilmiş constractor oluşturduk
  bu constr. geriye bir user nesnesi döndürür.
  bu parametre olarak içinde key değerleri strng value değerleri dynmc olan bir map sunuyor.
  buradan yeni bir user nesnesi gelsin istiyoruz.
  : dediğimiz için oluşturulacak user nesnesine hitap eder
  */

  User.fromMap(Map<String, dynamic> map):
    userID = map['userID'],
    email = map['email'],
    userName = map['userName'],
    profilURL = map['profilURL'],
    createdAt = (map['createdAt'] as Timestamp).toDate() ,
    updatedAt = (map['updatedAt'] as Timestamp).toDate(),
    seviye = map['seviye'];

  @override
  String toString() {
    return 'User{userID: $userID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, updatedAt: $updatedAt, seviye: $seviye}';
  }
}
