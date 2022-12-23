//bu sınıfta metodların sadece tanımları olacak.
//soyut sınıflar metodları barındırır ancak nası yaoılacağını bilmez.
//bu yüzden somut bir sınıf olan firestora_db_store dosyasını oluşturduk.

import 'package:zapp/model/user_model.dart';

abstract class DBBase{
  Future<bool> saveUser(User user);
  /*
  kullanıcı user_repository'de  email ve şifre ile kayıt yapınca bir user nesnes oluşur. Biz onu bekliyoruz.
  yani oturum açıldıktan sonra kaydetme işlemini yapıyoruz.
  kayıt işleminin başarılı olup olmadığını bool bir değer döndürerek anlayabiliyoruz.
  */
}