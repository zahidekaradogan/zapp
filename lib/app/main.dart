import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zapp/viewmodel/user_model.dart';

import '../locate.dart';
import 'landing_page.dart';


void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        title: 'Zapp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Color.fromRGBO(96, 108, 56, 1)),
        home: LandingPage(),),
    );
  }
}
