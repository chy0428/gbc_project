import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class MyPage extends StatelessWidget {
  final FirebaseUser user;
  MyPage(this.user);
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //바탕화면 색깔 핑꾸
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: 340,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(
                      "https://user-images.githubusercontent.com/47182864/62646980-7b7e2200-b98a-11e9-8fb8-c5cebc3c3cce.jpg"),
                      fit: BoxFit.cover)
              ),
              child: Stack(
                children: <Widget>[
                  //user information 위치
                  Positioned(
                    top: 80,
                    left: 24,
                    right : 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.photoUrl),
                            ),
                          ),
                          // 프로필 사진과 계정 정보 사이 간격
                          Padding(padding: const EdgeInsets.all(8.0)),
                          Text(user.email,style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.5
                          ),),
                          Text(user.displayName,
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.5
                            ),),
                        ]
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 230,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(64),
                    topRight: Radius.circular(64),
                  )
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 28,
                      top: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height:  32,
                          width: 32,
                          decoration: BoxDecoration(
                              border: Border.all()
                          ),
                          child: Icon(Icons.exit_to_app, size: 14,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 90,),
                  Container(
                      height: 52,
                      margin: EdgeInsets.only(left: 32, right: 32),
                      decoration: BoxDecoration(
                          color: Colors.pink[100],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      child: Center(
                          child: RaisedButton(
                            child: Text("Logout", style: TextStyle(
                                color:Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                            //로그아웃 하기
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              _googleSignIn.signOut();
                              print("User Sign Out");
                            },
                          )
                      )
                  )
                ],
              ),
            ),
          ),
        ],
      ),);
  }
}

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('My Page')
//        ),
//        body: Center(
//          child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//            Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: RaisedButton(
//                  child: Text('내가 남긴 리뷰', style: TextStyle(fontSize: 24)),
//                  onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => ReviewList() ),
//                  );
//                  },
//                ),
//            ),
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: RaisedButton(
//                    child: Text('로그아웃', style: TextStyle(fontSize: 24)),
//                    //로그아웃 하기
//                    onPressed: () {
//                      FirebaseAuth.instance.signOut();
//                      _googleSignIn.signOut();
//                    },
//                      //icon: Icon(Icons.exit_to_app);
//                  ),
//                ),
//    ])));
//  }
//}
//
//// TODO: 내가 작성한 리뷰 목로 보여줄거야아ㅏ아
//class ReviewList extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("내가 남긴 리뷰",
//            //style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//          ),
//        ));
//  }
//}