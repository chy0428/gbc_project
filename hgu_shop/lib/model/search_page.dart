import 'package:flutter/material.dart';
import '../cafe_page.dart';
import '../facilities_page.dart';
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
}
class DataSearch extends SearchDelegate<String> {
  final List<String> Stores = <String>[
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
    '투썸 플레이스',
    '달콤커피 장성점',
    '카페콩',
    '디저트39',
    '양덕동 마카롱',
    '잇브레드',
    '클래식 북스',
    '모캄보',
    '엣지브라운',
    '미즈앤맘 산부인과',
    '포항온천',
    '디자인짐',
    '라안요가 필라테스',
    '양덕광천수온천',
    '클푸',
    '다비치 안경',
    'ABC볼링장',
    '알파 문구 양덕',
    '밝은성모안과',
    '만화라떼24시',
    '바디 팩토리',
    '이가자 헤어비스',
    '바이크 엣지',
    '중앙콘택트안경점',
    '극동렌트카',
    'only u gym',
    '메디컬 닥터스',
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
    '투썸 플레이스',
    '달콤커피 장성점',
    '카페콩',
    '디저트39',
    '양덕동 마카롱',
    '잇브레드',
    '클래식 북스',
    '모캄보',
    '엣지브라운',
    '미즈앤맘 산부인과',
    '포항온천',
    '디자인짐',
    '라안요가 필라테스',
    '양덕광천수온천',
    '클푸',
    '다비치 안경',
    'ABC볼링장',
    '알파 문구 양덕',
    '밝은성모안과',
    '만화라떼24시',
    '바디 팩토리',
    '이가자 헤어비스',
    '바이크 엣지',
    '중앙콘택트안경점',
    '극동렌트카',
    'only u gym',
    '메디컬 닥터스',
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
  Widget buildLeading(BuildContext context) {
    //
    // leading icon on the left of the app bar
    return IconButton(icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    var i = 0;
    var index = 0;
    for(i = 0; i<44; i++){
      if(Stores[i].startsWith(query)) {
        break;
      }
    }
    if(i < 17){
      return Screen(idx: i,food: Stores[i]);
    }else if(i > 16 && i < 26){
      index = i - 17;
      return CScreen(idx: index,Cafe: Stores[i]);
    }else {
      index = i - 26;
      return FScreen(idx: index, facility: Stores[i]);
    }
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