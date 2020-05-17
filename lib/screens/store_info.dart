import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopstock/backshop/api_caller.dart';
import 'package:shopstock/backshop/store.dart';
import 'package:shopstock/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StoreInfoState();
}

class _StoreInfoState extends State<StoreInfo> {
    String search = "";

    FutureBuilder _buildList(Store store) {
      var future = getItemsInStore(store.id);

      return FutureBuilder(
          builder:(context, snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data;
              return ListView.builder(itemBuilder: (context, item) {
                for(var item in items){
                  item.setLabelling(0.5);
                }

                if (item < items.length && items[item].name.toLowerCase().contains(search.toLowerCase())){
                  return ListTile(
                    title: Text(
                        items[item].name,
                        style: Theme.of(context).textTheme.bodyText1
                    ),
                    trailing: Container(
                      child: Padding(
                          child: Text(
                                  (confidence) {
                                const outs = <String>[
                                  "Out of Stock",
                                  "Likely Out of Stock",
                                  "Unknown",
                                  "Likely In Stock",
                                  "In Stock"
                                ];
                                return outs[min((((confidence + 1) / 2) * outs.length).floor(), outs.length - 1)];
                              }(items[item].labelling),
                              style: TextStyle(
                                color: AppColors.background,
                              )
                          ),
                          padding: EdgeInsets.fromLTRB(8, 4, 8, 4)
                      ),
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          color: (confidence) {
                            const double SAT = 0.6;
                            double hue = ((confidence + 1) / 2);
                            double red = sqrt(1 - (hue * SAT));
                            double green = sqrt((1 - SAT) + hue * SAT);
                            double blue = (1 - SAT);
                            return Color.fromARGB(0xFF, (red * 0xff).round(), (green * 0xff).round(), (blue * 0xff).round());
                          } (items[item].labelling)
                      ),
                    ),
                  );
                }
                return null;
              });
            }
            return WillPopScope(
              onWillPop: () async => false,
              child: Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        future: future,
      );
    }

  void _onTextChange(String str) {
    setState(() {
      search = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Store store = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(store.name),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          children: <Widget>[
            Padding(
              child: _buildAddressOptions(store),
              padding: EdgeInsets.fromLTRB(PADDING, PADDING, PADDING, 0),
            ),
            Padding(
              child: AppSearchBar(
                  onTextChange: _onTextChange
              ),
              padding: EdgeInsets.all(PADDING),
            ),
            Expanded(
                child: _buildList(store),
            ),
            Center(
              child: Row(
                  children: <Widget>[
                    AppButton(
                      text: "Navigate",
                      onPressed: () {
                        launch("geo:" + store.location.lat.toString() + "," + store.location.long.toString() + "?q=" + Uri.encodeComponent(store.name + " " + store.address)); // Android only
                        // TODO : Launch Maps on iOS
                      },
                    ),
                    AppButton(
                      text: "Report",
                      onPressed: () {
                        Navigator.pushNamed(context, "/map_explore/store_info/report", arguments: store);
                      },
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

    Widget _buildAddressOptions(Store store) {
      return PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          store.address,
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        color: AppColors.accentDark,
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<int>>[
            PopupMenuItem(
              value: 0,
              child: ListTile(
                leading: Icon(
                  Icons.content_copy,
                  color: AppColors.primary,
                ),
                title: Text(
                  "Copy Address",
                  style: TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ];
        },
        onSelected: (int choice) {
          if(choice == 0) {
            Clipboard.setData(ClipboardData(text: store.address));
          }
        },
      );
    }

}