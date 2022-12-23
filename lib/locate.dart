import 'package:get_it/get_it.dart';
import 'package:zapp/services/firestore_db_service.dart';

import 'repository/user_repository.dart';
import 'services/fake_auth_service.dart';
import 'services/firebase_auth_service.dart';

GetIt locator = GetIt(); //global bir get it nesnesi olurturduk her yerden ulaşabilmek için.

void setupLocator(){
  locator.registerLazySingleton(()=> FirebaseAuthService());
  locator.registerLazySingleton(()=> FakeAuthenticationService());
  locator.registerLazySingleton(()=> FirestoreDBService());
  locator.registerLazySingleton(()=> UserRepository());

}