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
          ClipPath(
            child: Container(color: Colors.black.withOpacity(0.8)),
            clipper: getClipper(),
          ),
          Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
            children: <Widget>[
              Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(user.photoUrl), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(75.0)),
              boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)])),
                SizedBox(height: 40.0),
                Text(user.displayName, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),),
                SizedBox(height: 15.0),
                Text(user.email, style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.italic, fontFamily: 'Montserrat'),),
                SizedBox(height: 25.0),
                Container(
                    height: 30.0,
                    width: 95.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReviewList())
                            );},
                        child: Center(
                          child: Text('My review', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),),
                        ),
                    ),
                    )),
                    SizedBox(height: 25.0),
                Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.redAccent,
                    color: Colors.red,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        _googleSignIn.signOut();
                        print("User Sign Out");
                      },
                      child: Center(
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ))
            ],
            ))
        ],
      ));

  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

//// TODO: 내가 작성한 리뷰 목로 보여줄거야아ㅏ아
class ReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("내가 남긴 리뷰",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ));
  }
}