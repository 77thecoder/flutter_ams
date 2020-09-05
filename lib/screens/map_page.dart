import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapOffice extends StatefulWidget {
  @override
  _MapOfficeState createState() => _MapOfficeState();
}

class _MapOfficeState extends State<MapOffice> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(52.022109,47.821920),
    zoom: 17,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(52.0219373,47.8199673),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final Set<Marker> _markers = Set();


  @override
  void initState() {
    _markers.add(
      Marker(
        markerId: MarkerId('Мой офис'),
        infoWindow: InfoWindow(title: 'Мой офис: г. Балаково, ул. Трнавская д.5'),
        position: LatLng(52.022109,47.821920),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Где мой офис?'),
        backgroundColor: Colors.red,
      ),
      body: _mapPage(),
    );
  }

  Widget _mapPage() {
    return Stack(
      children: <Widget>[
        GoogleMap(
          mapType: MapType.normal,
          markers: _markers,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        )
      ],
    )
    ;
  }
}

// class _mapPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       mapType: MapType.hybrid,
//       initialCameraPosition: _kGooglePlex,
//       onMapCreated: (GoogleMapController controller) {
//         _controller.complete(controller);
//       },
//     );
//   }
// }
