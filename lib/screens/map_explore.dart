import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopstock/theme.dart';

class MapExplore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapExploreState();
}

class _MapExploreState extends State<MapExplore> {
  void _onMarkerTap() {
    Navigator.pushNamed(context, "/map_explore/store_info");
  }

  @override
  Widget build(BuildContext context) {
    var _markers = <Marker>[
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
    for (int i = 0; i < _markers.length; i++) {
      center = LatLng(center.latitude + (_markers[i].position.latitude / _markers.length), center.longitude + (_markers[i].position.longitude / _markers.length));
    }

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
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: center,
                        zoom: 17.0
                    ),
                    markers: _markers.toSet(),
                  ),
                padding: EdgeInsets.all(PADDING),
              ),
            ),
          ],
        ),
      ),
    );
  }
}