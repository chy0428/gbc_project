import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hgu_shop/tab_page.dart';

import 'login_page.dart';

class RootPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    //if login / 그냥 들어갈 것인지
    return StreamBuilder<FirebaseUser>(
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        return TabPage(snapshot.data);
      } else {
        return LoginPage();
      }
      },
    );
  }
}