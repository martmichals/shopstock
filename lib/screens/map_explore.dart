import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopstock/backshop/api_caller.dart';
import 'package:shopstock/backshop/report.dart';
import 'package:shopstock/theme.dart';
import 'package:shopstock/backshop/session_details.dart';
import '../backshop/coordinate.dart';
import '../backshop/store.dart';

GoogleMapController gMapController;

class MapExplore extends StatefulWidget {
  MapExplore({Key key}) : super(key: key);
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
        // TODO : Delete the following test code
        Session.userReport = Report(store);
        print('Testing toJson Method');
        sendReport();
        // TODO : End here


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
        //final stores = await Session.mapHandler.getStoresInScreen(sw, ne);
        final stores = <Store> [
          Store(
            0,
            "Name",
            "Address ",
            Coordinate(42, -88)
          )
        ];
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child:  AppSearchBar(
                      onTextChange: (string) {},
                    ),
                  ),
                  buildUserDropdown(),
                ],
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

  var _userChoices = ["Logout", "Change Password", "Cancel"];

  Widget buildUserDropdown() {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: AppColors.accentDark,
      icon: Icon(
        Icons.account_circle,
        color: AppColors.accent,
        size: 30.0,
      ),
      itemBuilder: (BuildContext context) {
        return _userChoices.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
          );
        }).toList();
      },
      onSelected: _choiceAction,
    );
  }

  void _choiceAction(String choice) {
    if (choice == _userChoices[0]) {
      // TODO logout functionality
      Navigator.pushReplacementNamed(context, "/log_in");
    } else if (choice == _userChoices[1]) {
      // TODO change password functionality
    }
  }

}