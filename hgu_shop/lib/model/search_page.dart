import 'package:flutter/material.dart';
import '../food_page.dart';


class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return DataSearch();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo.png', width: 80),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,),
              onPressed: (){
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body: Center(child: Photo()),
    );
  }
}
class Photo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox.expand(
      child: Image.asset(
          'images/photo3.png',
          fit: BoxFit.cover
      ),
    );

  }
//  @override
////  Widget build(BuildContext context) {
////    return Column(children: <Widget>[
////      Row(children: <Widget>[
////        makeImage(BoxFit.fill),
////        makeImage(BoxFit.fill),
////      ]),
////      Row(children: <Widget>[
////        makeImage(BoxFit.fill),
////        makeImage(BoxFit.fill),
////      ]),
////      Row(children: <Widget>[
////        makeImage(BoxFit.fill),
////        makeImage(BoxFit.fill),
////      ]),
////    ]);
}

//  Widget makeImage(BoxFit option) {
//    return Container(
//      child: Image.asset('images/photo.jpeg', width: , height: 150, fit: option),
//      padding: EdgeInsets.only(left: 2, right: 2, bottom: 1),
//    );
//  }
//}

class DataSearch extends SearchDelegate<String> {

  final List<String> Stores = <String> [
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

  final List<String> recentStores = <String>[
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
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) { //
    // leading icon on the left of the app bar
    return IconButton(icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation),
        onPressed: (){
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    var i = 0;
    for(i = 0; i<16; i++){
      if(Stores[i].startsWith(query)) {
        break;
      }
    }
    return Screen(idx: i, food: Stores[i]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searchs for something
    final suggestionList = query.isEmpty
        ?recentStores
        :Stores.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context,index) => ListTile(
        onTap: (){
          showResults(context);
        },
//        onTap: (){
//          var i = 0;
//          for(i = 0; i<17; i++){
//            if((Stores[index] == Stest[i])) {
//              break;
//            }
//          }
//          //Screen(idx: index, food: 'food');
//          Navigator.push(context,
//          MaterialPageRoute(builder: (context) => Screen(idx: i, food: Stest[i]))
//          );
//        },
        leading: Icon(Icons.location_city), // Icon 변경 가능
        title: RichText(text: TextSpan(
            text: suggestionList[index].substring(0,query.length),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold
            ),
            children: [TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey)
            )]
        ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}