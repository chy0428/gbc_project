import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hgu_shop/review/posts.dart';
import 'UploadPhoto_page.dart';

// 업로드 했을 때 쓰이는 기능

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  List<Posts> postsList = [];

  @override
  void initState(){
    super.initState();
    // 여기서 Posts는 데이터베이스에 Posts 라는 항목을 말함.
    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Posts");

    postsRef.once().then((DataSnapshot snap){
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postsList.clear();

      for(var individualKey in KEYS){
        Posts posts = Posts(
          DATA[individualKey]['image'],
          DATA[individualKey]['description'],
          DATA[individualKey]['date'],
          DATA[individualKey]['time'], // database 정보들
        );
        postsList.add(posts);
      }

      setState(() {
        print('Length : $postsList.length');
      });
    });
  }

  Widget PostsUI(String image, String description, String date, String time){
    return new Card(
        elevation: 10.0,
        margin: EdgeInsets.all(15.0),

        child: Container(
          padding: EdgeInsets.all(14.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  Text(
                    date,
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),

              SizedBox(height: 10.0,),

              new Image.network(image, fit: BoxFit.cover,),

              SizedBox(height: 10.0,),

              Text(
                description,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Page'),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: postsList.length == null? Text("No review available"):
             new ListView.builder(
          itemCount: postsList.length,
          itemBuilder: (_, index){
            return PostsUI(
              postsList[index].image,
              postsList[index].description,
              postsList[index].date,
              postsList[index].time,
            );
          },
        ),
      ),
    );
  }
}