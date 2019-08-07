import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

mixin Option implements StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HGU shop',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

      ),
      body: MyPage(),

    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('내가 남긴 리뷰', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReviewList() ),
                  );
                  },
                ),
            ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('로그아웃', style: TextStyle(fontSize: 24)),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      _googleSignIn.signOut();
                    },
                      //icon: Icon(Icons.exit_to_app);
                  ),
                ),
    ])));
  }
}

// TODO: 내가 작성한 리뷰 목로 보여줄거야아ㅏ아
class ReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("내가 남긴 리뷰",
            //style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
