import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hgu_shop/review/posts.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<Posts> postMessages = List();
  Posts posts;

  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();

    posts = Posts("", "");
    databaseReference = database.reference().child("post_board");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }
  Widget PostsUI(String image, String description, String date, String time) {
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    time,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),

              SizedBox(height: 10.0,),

              new Image.network(image, fit: BoxFit.cover,),

              SizedBox(height: 10.0,),

              Text(
                description,
                style: Theme
                    .of(context)
                    .textTheme
                    .subhead,
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
        title: Text('Review Page', style: TextStyle(color: Colors.pink),),
        backgroundColor: Colors.white,
      ),

      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.subject),
                        title: TextFormField(
                            decoration: InputDecoration(
                                hintText: "제목을 입력하세요."
                            ),
                            initialValue: "",
                            onSaved: (value) => posts.subject = value,
                            validator: (value) => value == "" ? value : null)),
                    ListTile(
                        leading: Icon(Icons.message),
                        title: TextFormField(
                            decoration: InputDecoration(
                                hintText: "내용을 입력하세요."
                            ),
                            initialValue: "",
                            onSaved: (value) => posts.body = value,
                            validator: (value) => value == "" ? value : null)),
                    /*FlatButton(
                      child: Text("Save"),
                      color: Colors.redAccent,
                      onPressed: () {
                        _submitPostForm();
                      },
                    )*/
                    Padding(
                      padding: EdgeInsets.all(20.0),
                    ),
                    FloatingActionButton.extended(
                      onPressed: (){
                        _submitPostForm();
                      },
                      icon: Icon(Icons.edit, color: Colors.pink,),
                      label: Text("Post Up"),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pink,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
          Flexible(
            child: FirebaseAnimatedList(
                query: databaseReference,
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Card(
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.message),
                      ),
                      title: Text(postMessages[index].subject),
                      subtitle: Text(postMessages[index].body),
                    ),
                  );
                }),
          ),
          /*IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReviewPage())
              );
            },
          ),*/
        ],
      ),
    );
  }

  void _onEntryAdded(Event event) {
    setState(() {
      postMessages.add(Posts.fromSnapshot(event.snapshot));
    });
  }

  void _submitPostForm() {
    final FormState state = formKey.currentState;

    if (state.validate()) {
      state.save();
      state.reset();

      databaseReference.push().set(posts.toJson());
    }
  }

  void _onEntryChanged(Event event) {
    var oldData = postMessages.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      postMessages[postMessages.indexOf(oldData)] =
          Posts.fromSnapshot(event.snapshot);
    });
  }
}