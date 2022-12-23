import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zapp/model/user_model.dart';

import 'database_base.dart';

class FirestoreDBService implements DBBase {
  final Firestore _firebaseAuth = Firestore.instance;

  @override
  Future<bool> saveUser(User user) async {
    /*
    createdAt ve updatedAt firestora özgü olduğu için burada ele aldık daha sonra modelin içerisinde ele almanın daha temiz olduğunu düşündük.
    1. yöntem;

    Map _eklenecekUserMap = user.toMap();
    _eklenecekUserMap['createdAt'] = FieldValue.serverTimestamp();
    _eklenecekUserMap['updatedAt'] = FieldValue.serverTimestamp();,

    2. yöntem;

    _eklenecekUserMap.addAll(<String, dynamic>{
      'yeniAlan' : "yeni alan",
    });

    */

    await _firebaseAuth
        .collection("users")
        .document(user.userID)
        .setData(user.toMap());

    DocumentSnapshot _okunanDeger =
        await Firestore.instance.document("Users/${user.userID}").get();

    Map _okunanUserBilgileriMap = _okunanDeger.data;
    User _okunanUserBilgileriNesne = User.fromMap(_okunanUserBilgileriMap);
    print("Okunan user nesnesi:" + _okunanUserBilgileriNesne.toString());
    return true;
  }
}
