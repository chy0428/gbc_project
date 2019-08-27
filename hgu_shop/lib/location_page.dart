import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Store_LocationPage extends StatefulWidget {
  @override
  _Store_LocationPageState createState() => _Store_LocationPageState();
}

class _Store_LocationPageState extends State<Store_LocationPage> {
  List<Marker> allMarkers=[];

  GoogleMapController _controller;

  @override
  void initState(){
    super.initState();
    allMarkers.add(Marker(markerId: MarkerId('handong'),
        draggable: false, // marker 드래그 불가능 상태


        onTap: (){
          print('Marker Tapped');
        },
        position: LatLng(36.103168, 129.388455)
    ));
    allMarkers.add(Marker(markerId: MarkerId('죽도시장'),
        draggable: false, // marker 드래그 불가능 상태
        onTap: (){
          print('Marker Tapped');
        },
        position: LatLng(36.036266, 129.366775)
    ));
    allMarkers.add(Marker(markerId: MarkerId('롯데시네마'),
        draggable: false, // marker 드래그 불가능 상태
        onTap: (){
          print('Marker Tapped');
        },
        position: LatLng(36.036880, 129.362968)
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
                target: LatLng(36.103168, 129.388455), // 한동대 위도 경도
                zoom: 12.0
            ),
              markers: Set.from(allMarkers), // marker
              onMapCreated: mapCreated,
            ),
          ),
            /*Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: movetoHandong,
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.green
              ),
              child: Icon(Icons.forward, color: Colors.white,),
            ),
          ),
        ),*/
            /*Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: movetoJukdoMarket,
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.red
                ),
                child: Icon(Icons.backspace, color: Colors.white,),
              ),
            ),
          )*/
          ]
      ),
    );
  }

  void mapCreated(controller){
    setState(() {
      _controller = controller;
    });
  }

  // 위치 추가 (수정하면됨) 음식점들
  movetoHandong(){
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(36.103168, 129.388455),
            zoom: 14.0,bearing: 45.0,tilt: 45.0)
    ));
  }
  movetoJukdoMarket(){
    _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(36.036266, 129.366775),
            zoom: 12.0)
    ));
  }
}