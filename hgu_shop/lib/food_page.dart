import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hgu_shop/review/upload_page.dart';
import 'location_page.dart';
import "package:url_launcher/url_launcher.dart";



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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${Food[index]}', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                          Text('place', style: TextStyle(
                            color: Colors.pink[200],
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
//              FavoriteWidget(idx: index, food: Food[index]);
              print("Test1");
              print(index);
            },
          );
        },
      ),
    );

  }
}



class Screen extends StatelessWidget {
  final int idx;
  final String food;

  const Screen({Key key, this.idx, this.food}) : super(key: key);
//test(){
//  print("???");
//  print(idx);
//}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(food,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              FavoriteWidget(idx: idx, food: food[idx]),
            ],
          )
      ),
      backgroundColor: Colors.white,

      body: ListView(
        children: <Widget>[
          _buildImageSection(idx),
          _buildBotton(idx, food),
          _buildTimeSetting(),
          _buildTime(idx),
          _buildBenefitSetting(),
          _buildBenefit(idx)

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
            ],);
          }
      )
  );
}

_buildBotton(int idx, String food){
  return Container(
      color: Colors.white,
      child: StreamBuilder(
          stream: Firestore.instance.collection('요식업').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading data...');
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: _buildButtonItems(Icons.call, 'CALL'),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _showDialog(idx)),
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
                        MaterialPageRoute(builder: (context) =>
                            Food_Store_LocationPage(idx: idx, latitude: snapshot.data.documents[idx]['latitude'],
                            longitud: snapshot.data.documents[idx]['longitude'])),
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
                        MaterialPageRoute(builder: (context) => UploadPage(name: food)),
                      );
                    },
                  ),
                ),
              ],
            );
          })
  );

}

_showDialog(int idx) {
  return Container(
      child: StreamBuilder(
          stream: Firestore.instance.collection('요식업').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return Text('Loading data...');
            _callPhone() async {
              if (await canLaunch(snapshot.data.documents[idx]['''전화 번호'''])) {
                await launch(snapshot.data.documents[idx]['''전화 번호''']);
              } else {
                throw 'Could not Call Phone';
              }
            }
            return AlertDialog(
              title: Text('전화연결'),
              content: Text(snapshot.data.documents[idx]['''전화 번호'''],
                softWrap: true,
                style: TextStyle(
                    color: Colors.grey[500]
                ),),
              actions: <Widget>[
                FlatButton(child: Text('확인', style: TextStyle(color:
                Colors.pinkAccent)), onPressed: _callPhone),
                FlatButton(child: Text('취소', style: TextStyle(color:
                Colors.pinkAccent)), onPressed: () => Navigator.pop(context)),
              ],
            );
          }
      )
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
    margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
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

class FavoriteWidget extends StatefulWidget {
  final int idx;
  final String food;
  const FavoriteWidget({Key key, this.idx, this.food}) : super(key: key);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState(idx, food);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  final int idx;
  final String food;

  _FavoriteWidgetState(this.idx, this.food);

  var tmp;
  get child => null;


  void _toggleFavorite() {
    setState(() {
      if(_isFavorited) {
        print("Test2");
        print(idx);
        _isFavorited = false;
        //해당 페이지의 인덱스 저장
        return{
          child: StreamBuilder(
                stream: Firestore.instance.collection('요식업').snapshots(),
                builder: (context, snapshot) {
                  return tmp = snapshot.data.documents[idx]['foodID'];
                  },)
        };
        } else {
          _isFavorited = true;
          return 0;
        }
    });
  }

        @override
        Widget build(BuildContext context) {

      return Container (
        padding: EdgeInsets.all(0.0),
        child: IconButton(
          icon: (_isFavorited ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border, color: Colors.grey[700],)), color: Colors.red[500],
          onPressed: _toggleFavorite,

        ),

      );

//      child FutureBuilder(
//          future: _repository.isSaved(item),
//          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//            switch (snapshot.connectionState) {
//              case ConnectionState.waiting:
//              case ConnectionState.none:
//              case ConnectionState.active:
//                return Icon(Icons.favorite_border);
//              case ConnectionState.done:
//                return GestureDetector(
//                  child: Icon(
//                      snapshot.data ? Icons.favorite : Icons.favorite_border,
//                      color: snapshot.data ? Colors.red : null),
//                  onTap: () async{
//                    if (snapshot.data) {
//                      await _repository.removeItem(item);
//                    } else {
//                      await _repository.saveItem(item);
//                    }
//                    setState(() {
//
//                    });
//                  },
//                );
//            }
//          });

    }
}
