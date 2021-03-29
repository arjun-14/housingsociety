import 'package:flutter/material.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:collection';

class PieChartComplaints extends StatefulWidget {
  final Map<String, double> dataMap;
  PieChartComplaints({this.dataMap});

  @override
  _PieChartComplaintsState createState() => _PieChartComplaintsState();
}

class _PieChartComplaintsState extends State<PieChartComplaints> {
  dynamic noOfProblems;
  Map<String, double> sortedMap = {};
  Map<String, double> newDataMap = {};
  @override
  void initState() {
    super.initState();
    //newDataMap = widget.dataMap;
    print(widget.dataMap);
    var sortedKeys = widget.dataMap.keys.toList(growable: false)
      ..sort((k2, k1) => widget.dataMap[k1].compareTo(widget.dataMap[k2]));
    sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => widget.dataMap[k]);
    newDataMap = sortedMap;
    print(sortedMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart'),
      ),
      body: ListView(
        children: [
          Container(
            color: kXiketic,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration:
                              InputDecoration(labelText: 'No of problems'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              noOfProblems = value;
                            });
                          },
                        ),
                      ),
                      Builder(
                        builder: (BuildContext context) => TextButton(
                          onPressed: () {
                            if (int.parse(noOfProblems) < 1 ||
                                int.parse(noOfProblems) >
                                    widget.dataMap.length) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Okay'),
                                    )
                                  ],
                                  content: Text(
                                      'No of problems must be in the range 1-${widget.dataMap.length}'),
                                ),
                              );
                              // final snackBar = SnackBar(
                              //   content: Text(
                              //       'No of problems must be in the range 1-${widget.dataMap.length}'),
                              // );
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(snackBar);
                            } else {
                              newDataMap = {};

                              dynamic keys = sortedMap.keys;
                              print(keys);

                              for (var i = 0;
                                  i < int.parse(noOfProblems);
                                  i++) {
                                setState(() {
                                  newDataMap[keys.elementAt(i)] =
                                      sortedMap[keys.elementAt(i)];
                                });
                              }
                              print(newDataMap);
                            }
                          },
                          child: Text('Update'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                PieChart(
                  dataMap: newDataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartRadius: MediaQuery.of(context).size.width / 1.5,
                  legendOptions: LegendOptions(
                    showLegendsInRow: true,
                    legendPosition: LegendPosition.bottom,
                    showLegends: true,
                    legendShape: BoxShape.rectangle,
                    legendTextStyle: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: true,
                    decimalPlaces: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
