import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../Item.dart';

class Report extends StatelessWidget {
  ListView _buildList(String search) {
    print(search);
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, item) {
          if (item < Item.items.length && Item.items[item].toLowerCase().contains(search.toLowerCase())) {
            return AppItemTile(
              title: Item.items[item],
              onYes: () {

              },
              onNo: () {

              },
            );
          }
          return null;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: AppButton(
              text: "Add Item",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      String search = "";
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Dialog(
                            child: Column(
                              children: <Widget>[
                                AppSearchBar(
                                  onTextChange: (string) {
                                    setState(() {
                                      search = string;
                                    });
                                  },
                                ),
                                _buildList(search),
                              ],
                            ),
                            backgroundColor: Color.fromARGB(0, 0, 0, 0),
                          );
                        },
                      );
                    });
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (dateTime) {

                    },
                    backgroundColor: Colors.white,
                    mode: CupertinoDatePickerMode.dateAndTime,
                    minimumDate: DateTime.now().add(new Duration(days: -7)),
                    initialDateTime: DateTime.now(),
                    maximumDate: DateTime.now(),
                  ),
                  height: 300,
                ),
              ],
            ),
          ),
          Center(
              child: AppButton(
                text: "Report",
                onPressed: () {
                  Navigator.pushNamed(context, "/map_explore/store_info/report/infinity");
                },
              )
          )
        ],
      ),
    );
  }
}