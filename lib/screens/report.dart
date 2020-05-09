import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopstock/backshop/api_caller.dart';
import 'package:shopstock/backshop/session_details.dart';
import 'package:shopstock/backshop/store.dart';
import 'package:shopstock/item_report_list.dart';
import 'package:shopstock/backshop/report.dart' as backendReport;
import '../item_report.dart';
import '../theme.dart';

class Report extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  ItemReportList itemReportList = ItemReportList();
  DateTime visitTime = DateTime.now();

  ListView _buildReportList() {
    var list = itemReportList.getList().where((x) {
      return  x.status != 0;
    });
    var names = list.map((x) {
      return x.item.name;
    }).toList();
    var statuses = list.map((x) {
      return x.status;
    }).toList();
    if (names.length == 0) {
      return ListView(
        children: <Widget>[
          Padding(
            child: Center(
              child: Text(
                  "Add Item Report",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            padding: EdgeInsets.all(PADDING),
          ),
        ],
      );
    }
    else {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: names.length,
          itemBuilder: (context, item) {
            return ListTile(
              title: Text(
                  names[item],
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1
              ),
              trailing: Row(
                  children: <Widget>[
                    Container(
                      child: Padding(
                          child: Text(
                              (statuses[item] > 0 ? "In" : "Out of") + " Stock",
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
                          color: (statuses[item] > 0 ? AppColors.yes : AppColors
                              .no)
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: AppColors.accent,
                      ),
                      onPressed: () {
                        setState(() {
                          itemReportList.removeReport(names[item]);
                        });
                      },
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min
              ),
            );
          }
      );
    }
  }

  ListView _buildSelList(String search, setSubState) {
    var names = itemReportList.getList().where((x) {
      return x.item.name.toLowerCase().contains(search.toLowerCase()) && x.status == 0;
    }).toList().map((x) {
      return x.item.name;
    }).toList();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: names.length,
        itemBuilder: (context, item) {
          return AppItemTile(
            title: names[item],
            onYes: () {
              setSubState(() {
                itemReportList.setReport(names[item], true);
              });
              setState((){});
            },
            onNo: () {
              setSubState(() {
                itemReportList.setReport(names[item], false);
              });
              setState((){});
            },
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final Store store = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Report: " + store.storeName),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        decoration: backgroundDecoration(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildReportList(),
            ),
            Center(
              child: AppButton(
                text: "Add Item Reports",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        String search = "";
                        return StatefulBuilder(
                          builder: (context, setSubState) {
                            return Dialog(
                              child: Column(
                                children: <Widget>[
                                  AppSearchBar(
                                    onTextChange: (string) {
                                      setSubState(() {
                                        search = string;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: _buildSelList(search, setSubState),
                                  ),
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
            Text(
              "Time of visit:",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              child: CupertinoTheme(
                child: CupertinoDatePicker(
                  onDateTimeChanged: (dateTime) {
                    setState(() {
                      visitTime = dateTime;
                    });
                  },
                  mode: CupertinoDatePickerMode.dateAndTime,
                  minimumDate: DateTime.now().add(new Duration(days: -7)),
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime.now(),

                ),
                data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                        primaryColor: AppColors.accent
                    )
                ),
              ),
              height: 150,
            ),
            Center(
                child: AppButton(
                  text: "Report",
                  onPressed: () {
                    // Create the report
                    Session.userReport = backendReport.Report(store);
                    for (ItemReport itemReport in itemReportList.itemList) {
                      Session.userReport.addNewLabel(itemReport.item, itemReport.status);
                    }
                    Session.userReport.setTime(visitTime);

                    print('Report screen return:');
                    var future = sendReport();
                    LoadingDialog(
                        context: context,
                        snapshot: future,
                        onDone: (data) {
                          if (data == null) {
                            return Container();
                          }
                          else {
                            return ErrorText(
                                text: data
                            );
                          }
                        },
                        onError: (error) {
                          return ErrorText(
                              text: error.toString()
                          );
                        }
                    );

                    Navigator.pushNamedAndRemoveUntil(context, '/map_explore', (Route<dynamic> route) => false);
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}