import 'package:flutter/material.dart' show AppBar, BuildContext, Container, MediaQuery, Scaffold, Stack, State, StatefulWidget, Text, Widget;
// ignore: implementation_imports
import 'package:flutter/src/foundation/key.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: camel_case_types
class Store_LocationPage extends StatefulWidget {
  final int idx;

  const Store_LocationPage({Key key, this.idx}) : super(key: key);

  @override
  _Store_LocationPageState createState() => _Store_LocationPageState(idx);
}

// ignore: camel_case_types
class _Store_LocationPageState extends State<Store_LocationPage> {
  List<Marker> allMarkers=[];

  _Store_LocationPageState(int idx);
//
//  double get latitude => null;
//  double get longitude => null;

  @override
  void initState(){
    super.initState();


//    allMarkers.add(Marker(markerId: MarkerId('본카츠야'),
//        draggable: false, // marker 드래그 불가능 상태
//
//        onTap: (){
//          print('Marker Tapped');
//        },
//        position: LatLng(36.068351, 129.372673)
//    ));
//
//    allMarkers.add(Marker(markerId: MarkerId('서가앤쿡'),
//        draggable: false, // marker 드래그 불가능 상태
//
//        onTap: (){
//          print('Marker Tapped');
//        },
//        position: LatLng(36.079679, 129.397098)
//    ));
    allMarkers.add(Marker(markerId: MarkerId('모범 떡볶'),
        draggable: false, // marker 드래그 불가능 상태

        onTap: (){
          print('Marker Tapped');
        },
        position: LatLng(36.055427, 129.363059)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Stack(
          children: [Container( // 기준이되는 Marker
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(initialCameraPosition: CameraPosition(
                target: LatLng(36.055427, 129.363059), // 한동대 위도 경도
                zoom: 12.0
            ),
              markers: Set.from(allMarkers), // marker
              // onMapCreated: mapCreated,
            ),
          ),
          ]
      ),
    );
  }
}