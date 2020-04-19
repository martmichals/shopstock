import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopstock/theme.dart';
import '../backshop/store.dart';

class MapExplore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapExploreState();
}

class _MapExploreState extends State<MapExplore> {
  var _markers = <Marker>[];

  void _onMarkerTap() {
    Navigator.pushNamed(context, "/map_explore/store_info");
  }

  Marker _storeToMarker(Store store) {
    LatLng location = LatLng(
      store.location.lat,
      store.location.long
    );

    return Marker(
      markerId: MarkerId(store.storeID.toString()),
      position: location,
      infoWindow: InfoWindow(
        title: store.storeName,
        onTap: _onMarkerTap
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _tempMarkers = <Marker>[
      Marker(
          markerId: MarkerId("0"),
          position: new LatLng(41.894996, -87.629224),
          infoWindow: InfoWindow(
              title: "Whole Foods",
              onTap: _onMarkerTap
          ),
      ),
      Marker(
          markerId: MarkerId("1"),
          position: new LatLng(41.892316, -87.628676),
          infoWindow: InfoWindow(
              title: "Jewel Osco",
              onTap: _onMarkerTap
          ),
      ),
      Marker(
          markerId: MarkerId("2"),
          position: new LatLng(41.893514, -87.626310),
          infoWindow: InfoWindow(
              title: "Trader Joes",
              onTap: _onMarkerTap
          ),
      ),
    ];

    var center = LatLng(0, 0);
    for (int i = 0; i < _tempMarkers.length; i++) {
      center = LatLng(center.latitude + (_tempMarkers[i].position.latitude / _tempMarkers.length), center.longitude + (_tempMarkers[i].position.longitude / _tempMarkers.length));
    }

    GoogleMap gMap;
    GoogleMapController gMapController;
    gMap = GoogleMap(
      initialCameraPosition: CameraPosition(
          target: center,
          zoom: 15.0
      ),
      onMapCreated: (controller) {
        gMapController = controller;
      },
      onCameraMove: (camPos) {
        var bounds = gMapController.getVisibleRegion();
        var stores = <Store>[]; // = Backend.GetStoresByBound(bounds.northeast, bounds.southwest);
        setState(() {
          _markers = stores.map(_storeToMarker).toList();
        });
      },
      markers: _markers.toSet(),
    );


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              child: AppSearchBar(
                onTextChange: (string) {

                },
              ),
              padding: EdgeInsets.fromLTRB(PADDING, 0, PADDING, 0),
            ),
            Expanded(
              child: Padding(
                child: gMap,
                padding: EdgeInsets.all(PADDING),
              ),
            ),
          ],
        ),
      ),
    );
  }
}