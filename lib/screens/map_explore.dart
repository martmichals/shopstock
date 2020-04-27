import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopstock/theme.dart';
import 'package:shopstock/backshop/session_details.dart';
import '../backshop/coordinate.dart';
import '../backshop/store.dart';

GoogleMapController gMapController;

class MapExplore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapExploreState();
}

class _MapExploreState extends State<MapExplore> {
  var _markers = <Marker>[];

  Marker _storeToMarker(Store store) {
    LatLng location = LatLng(store.location.lat, store.location.long);

    return Marker(
      markerId: MarkerId(store.storeID.toString()),
      position: location,
      infoWindow: InfoWindow(title: store.storeName, onTap: () {
        Navigator.pushNamed(context, "/map_explore/store_info", arguments: store);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    GoogleMap gMap;
    gMap = GoogleMap(
      initialCameraPosition: CameraPosition(target: new LatLng(41.893514, -87.626310), zoom: 13.0),
      onMapCreated: (controller) {
        gMapController = controller;
      },
      onCameraIdle: () async {
        final bounds = await gMapController.getVisibleRegion();

        final sw = Coordinate.fromLatLng(bounds.southwest);
        final ne = Coordinate.fromLatLng(bounds.northeast);

        // print('Executing mapHandler.getStoresInScreen() method');
        final stores = await Session.mapHandler.getStoresInScreen(sw, ne);
        // print(Session.mapHandler);

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
                onTextChange: (string) {},
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
