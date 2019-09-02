import 'package:firebase_database/firebase_database.dart';

class Posts {
  String key;
  String subject;
  String body;

  Posts(this.subject, this.body);

  Posts.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        subject = snapshot.value["subject"],
        body = snapshot.value["body"];

  toJson() {
    return {"subject": subject, "body": body};
  }
}