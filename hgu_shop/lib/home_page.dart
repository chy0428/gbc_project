import 'package:flutter/material.dart'
    show AppBar, BuildContext, Center, Colors, Column, EdgeInsets, FontWeight, Image, InkWell, MainAxisAlignment, MaterialPageRoute, Navigator, Padding, RaisedButton, Row, Scaffold, State, StatefulWidget, StatelessWidget, Text, TextStyle, Widget;
import 'food_page.dart' show FoodScreen;
import 'cafe_page.dart' show CafeScreen;
import 'facilities_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/logo.png', width: 80),
            ],
          )
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
              child: InkWell(
                child: Image.asset('images/food.png', width: 270),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FoodScreen() ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: Image.asset('images/cafe.png', width: 270),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CafeScreen() ),
                  );
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                child: Image.asset('images/geta.png', width: 270),
                onTap: () {
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