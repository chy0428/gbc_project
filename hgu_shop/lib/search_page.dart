import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Store'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {

  final Stores=[
    '엽기떡볶이',
    'raracost',
    '롯데리아',
    '맥도날드',
    '신전떡볶이',
    '투썸플레이스',
    '스타벅스',
    '설빙',
    '한동대 편의점',
    '한동대 매점',
    '이디야',
    '학관',
  ];

  final recentStores = [
    '한동대 편의점',
    '한동대 매점',
    '이디야',
    '학관',
    '엽기떡볶이',
    'raracost',
    '롯데리아',
    '맥도날드',
    '신전떡볶이',
    '투썸플레이스',
    '스타벅스',
    '설빙',
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
    return Container( // 이건 예시이므로 한개의 함수를 만들고
      height: 100.0, //그 안에 다른 함수들을 넣어 각 경우 마다 page를 달리한다.
      width: 100.0,
      child: Card(
        color: Colors.red,
        shape: StadiumBorder(),
        child: Center(
          child: Text(query),
        ),
      ),
    );
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