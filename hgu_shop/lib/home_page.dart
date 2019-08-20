import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HGU shop',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

      ),
      body: Options(),
    );
  }
}

class Options extends StatefulWidget {
  @override
  OptionsState createState() => new OptionsState();
}

class OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('요식업', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FoodScreen() ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('카페 & 베이커리', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CafeScreen() ),
                  );
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('편의시설 & 기타', style: TextStyle(fontSize: 24)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FacilitiesScreen() ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("요식업",
        //style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('요식업').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData) return Text('Loading data...');
              return ListView.builder(
                padding: const EdgeInsets.all(4.0),
                itemBuilder: (context, i){
                  return new ListTile(
                    title: new Text('모범 떡볶이'),
                    subtitle: new Text('북구 천마로 46번길 40', style: new TextStyle(fontStyle: FontStyle.italic, color: Colors.green)),
                    leading: const Icon(Icons.restaurant),
                  );
                },
              );
            }
        )
    );
  }
}

class CafeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("카페 & 베이커리"),
      ),
    );
  }
}

class FacilitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("편의시설 & 기타"),
      ),
    );
  }
}
