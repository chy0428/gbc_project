import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'location_page.dart';



class FoodScreen extends StatelessWidget {
  final List<String> Food = <String>[
    '본카츠야',
    '서가앤쿡',
    '모범떡볶이',
    '라라코스트',
    '오랑 발리',
    '도르리 식당',
    '동궁 찜닭 (양덕점)',
    '토시래',
    '라멘 베라보',
    '9월애',
    '일봉 족발',
    '쌀통닭',
    '신전 떡볶이',
    '논스탠다드',
    '달인의 찜닭',
    '호식이 두마리 치킨',
    '맛찬들 왕소금 구이',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("요식업"),
      ),
      body: ListView.builder(
        itemCount: Food.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            title: Container(
              margin: EdgeInsets.fromLTRB(16, 9, 16, 9),
              child: Row(
                children: <Widget>[
                  Icon(Icons.restaurant),
                  Text('         '),
                  Container(
//                      width: 280.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${Food[index]}', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                          Text('place', style: TextStyle(
                              color: Colors.grey[500]
                          ),),
                        ],
                      )
                  )
                ],
              ),
            ),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Screen(idx: index, food: Food[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Screen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final int idx;
  final String food;
  // In the constructor, require a Todo.
  Screen({Key key, @required this.idx, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(food,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.favorite_border, color: Colors.grey[700],)
            ],
          )

      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          _buildImageSection(idx),
          _buildBotton(idx),
          _buildTimeSetting(),
          _buildTime(idx),
          _buildBenefitSetting(),
          _buildBenefit(idx)
//          _buildTitleSection(idx),
//          _buildButtonSection(idx),
//          _buildTextSection()
        ],
      ),
    );
  }
}


_buildImageSection(int idx){

  return Container(
      child: StreamBuilder(
          stream: Firestore.instance.collection('요식업').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return Text('Loading data...');
            return Column(children: <Widget>[
              Image.network(snapshot.data.documents[idx]['photo2'])
            ],
            );
          }
      )
  );//Image.network('https://scontent-frt3-2.cdninstagram.com/v/t51.2885-15/e35/s1080x1080/68691547_1170594069806054_2682214321596042182_n.jpg?_nc_ht=scontent-frt3-2.cdninstagram.com&oh=a54dd9b0fb9b4aeb0c4493a910f29c8e&oe=5DF0E8F8&ig_cache_key=MjExMjI2OTM3MDg5MjgxNTE5Mw%3D%3D.2',fit:BoxFit.fill);
}

_buildBotton(int idx){
  return Container(
      color: Colors.white,
      child: StreamBuilder(
          stream: Firestore.instance.collection('요식업').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading data...');
            return Row(
              //crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    //materialTapTargetSize: ,
                    child: _buildButtonItems(Icons.call, 'CALL'),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmptyPage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child:  _buildButtonItems(Icons.place, 'PLACE'),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmptyPage()),
                      );
                    },

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: _buildButtonItems(Icons.create, 'REVEIW'),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmptyPage()),
                      );
                    },
                  ),
                ),
              ],
            );
          })
  );
}
_buildButtonItems(IconData icon, String name){
  return Column(
    children: <Widget>[
      Icon(icon, color: Colors.grey[700],),
      Text(name, style: TextStyle(
        color: Colors.grey[700],
      )
      ),
    ],
  );
}

_buildTimeSetting(){
  return Container(
    color: Colors.white,
    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
    child: Text('영업시간', style: TextStyle(
      color: Colors.grey[800],
      fontSize: 13,
      fontWeight: FontWeight.bold,)
    ),
  );
}

_buildTime(int idx){
  return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(32, 0, 16, 0),
      child: StreamBuilder(
          stream: Firestore.instance.collection('요식업').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return Text('Loading data...');
            return Container(
                margin: EdgeInsets.all(16),
                child: Text(snapshot.data.documents[idx]['''영업시간'''],
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.grey[500]
                  ),)
            );
          })
  );
}

_buildBenefitSetting(){
  return Container(
    color: Colors.white,
    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
    child: Text('HGU 혜택', style: TextStyle(
      color: Colors.grey[800],
      fontSize: 13,
      fontWeight: FontWeight.bold,)
    ),
  );
}

_buildBenefit(int idx){
  return Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(32, 0, 16, 0),
      child: StreamBuilder(
          stream: Firestore.instance.collection('요식업').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading data...');
            return

              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  snapshot.data.documents[idx]['혜택'], style: TextStyle(
                    color: Colors.grey[500]),
                ),);
          }
      ));
}

_buildName(int idx){
  return Container(
      margin: EdgeInsets.all(16),
      child: StreamBuilder(
          stream: Firestore.instance.collection('요식업').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return Text('Loading data...');
            return Text(snapshot.data.documents[idx]['''name'''],
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:24
              ),);
          }
      ));

}


_buildTitleSection(int idx){
  return Container(
      margin: EdgeInsets.all(16),
      child: StreamBuilder(
          stream: Firestore.instance.collection('요식업').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return Text('Loading data...');

            return Row(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(snapshot.data.documents[idx]['''name'''],
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:24
                    ),),
                  Row(
                    children: <Widget>[
                      Text('영업시간', style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,)),
                      Text(snapshot.data.documents[idx]['''영업시간'''],

                        softWrap: true,
                        style: TextStyle(
                            color: Colors.grey[500]
                        ),),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Text('HGU 혜택', style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,)),
                      Text(snapshot.data.documents[idx]['혜택'],style: TextStyle(
                          color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ],
            );
          }));
}


_buildButtonSection(int idx){
  return Container(
    margin: EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
//        new GestureDetector(
//        onTap: () => Navigator.push(_buildButtonItem(Icons.call, Colors.pink, 'CALL'),
//            MaterialPageRoute(builder: (context) => Store_LocationPage())),

        _buildButtonItem(Icons.call, Colors.pink, 'CALL'),
        _buildButtonItem(Icons.place, Colors.pink, 'PLACE'),
        _buildButtonItem(Icons.favorite_border, Colors.pink, 'LIKE'),
      ],
    ),
  );
}

_buildButtonItem(IconData icon, MaterialColor color, String name){
  return Column(
    children: <Widget>[
      Icon(icon, color: color,),
      Text(name, style: TextStyle(color: color),),
    ],
  );
}


class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("EmptyPage"),
      ),
    );
  }
}