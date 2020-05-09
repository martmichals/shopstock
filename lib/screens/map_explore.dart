import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopstock/backshop/api_caller.dart';
import 'package:shopstock/backshop/local_data_handler.dart';
import 'package:shopstock/backshop/report.dart';
import 'package:shopstock/theme.dart';
import 'package:shopstock/backshop/session_details.dart';
import 'package:url_launcher/url_launcher.dart';
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
        // Create user report with the selected store as the store of interest
        Session.userReport = Report(store);
        Navigator.pushNamed(context, "/map_explore/store_info", arguments: store);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    GoogleMap gMap; // TODO: Add API-KEY on iOS
    gMap = GoogleMap(
      initialCameraPosition: CameraPosition(target: new LatLng(41.893514, -87.626310), zoom: 13.0),
      onMapCreated: (controller) {
        gMapController = controller;
      },
      onCameraIdle: () async {
        final bounds = await gMapController.getVisibleRegion();

        // Updating the stores on screen
        final sw = Coordinate.fromLatLng(bounds.southwest);
        final ne = Coordinate.fromLatLng(bounds.northeast);
        final stores = await Session.mapHandler.getStoresInScreen(sw, ne);

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
                      onTextChange: (string) {}, // TODO: Add search bar functionality
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

  void _choiceAction(String choice) async{
    if (choice == _userChoices[0]) {
      if(await wipeKey()) {
        if (await logout()) {
          Navigator.pushReplacementNamed(context, "/log_in");
        }
      }
      return;
    } else if (choice == _userChoices[1]) {
      // Launch the reset password url
      const url = 'https://shopstock.live/reset_password/';
      if (await canLaunch(url)) {
        await launch(url);
      }else{
        print('Error opening the url');
      }

    }
  }

}