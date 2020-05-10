import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopstock/backshop/api_caller.dart';
import 'package:shopstock/backshop/local_data_handler.dart';
import 'package:shopstock/backshop/report.dart';
import 'package:shopstock/theme.dart';
import 'package:shopstock/backshop/session_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
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

  Widget getLoading() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    var future = getItemsCategories();
    future.then((success) {
     if(!success)
       Navigator.pushReplacementNamed(context, "/log_in");
    });
  }

  @override
  Widget build(BuildContext context) {
    Location location = Location();

    var gMap = StatefulBuilder(
      builder: (context, setState) {
        var permissionEnabled = location.hasPermission();
        return FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == PermissionStatus.granted) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    var serviceEnabled = location.serviceEnabled();
                    return FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data) {
                              var pos = location.getLocation().then((value) {
                                if (value == null) {
                                  throw("Error finding location");
                                }
                                else {
                                  return LatLng(value.latitude, value.longitude);
                                }
                              });
                              return FutureBuilder(
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Expanded(
                                      child: Center(
                                        child: Column(
                                          children: <Widget>[
                                            ErrorText(text: "Location Error!"),
                                            AppButton(
                                              text: "Reload",
                                              onPressed: () {
                                                setState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  else if (snapshot.hasData) {
                                    return GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                          target: snapshot.data, zoom: 12.0),
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
                                  }
                                  return getLoading();
                                },
                                future: pos,
                              );
                            }
                            else {
                              return Expanded(
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      ErrorText(text: "Enable Location and Reload"),
                                      AppButton(
                                        text: "Enable Location",
                                        onPressed: () {
                                          location.requestService();
                                        },
                                      ),
                                      AppButton(
                                        text: "Reload",
                                        onPressed: () {
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }
                          return Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        future: serviceEnabled
                    );
                  },
                );
              }
              else {
                return Expanded(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        ErrorText(text: "Enable Location Permission in Settings and Reload"),
                        AppButton(
                          text: "Reload",
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            return getLoading();
          },
          future: permissionEnabled,
        );
      },
    );

    // TODO: Add API-KEY on iOS

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: backgroundDecoration(),
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
                    _buildUserDropdown(),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(PADDING, 0, PADDING, 0),
              ),
              Expanded(
                child: Padding(
                  child: ClipRRect(
                    borderRadius:BorderRadius.all(Radius.circular(PADDING)),
                    child: gMap,
                  ),
                  padding: EdgeInsets.all(PADDING),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var _userChoices = ["Logout", "Change Password", "Cancel"];

  Widget _buildUserDropdown() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0, 0, 12, 15),
      child: PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: AppColors.accentDark,
        icon: Icon(
          Icons.account_circle,
          color: AppColors.accent,
          size: 55.0,
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
      ),
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