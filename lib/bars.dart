import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'singleton.dart' as singleton;
import 'package:test_project/data.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class Bars extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => BarsState();

}

class BarsState extends State<Bars>{
  List<charts.Series> seriesList;
  String text = "";
  int indexSelection = -1;
  List<DisabilityAgeEntry> disabilityAgeData;

  @override
  Widget build(BuildContext context) {
    List<List> data = singleton.DataSingleton.getInstance().byAge;
    List<DisabilityAge> data_list = [];
    disabilityAgeData = [];
    List<charts.Color> colors = [
      new charts.Color(
          r: 31, g:119, b:180, a:255),
      new charts.Color(
          r: 148, g:103, b:189, a:255),
      new charts.Color(
          r: 140, g:86, b:75, a:255),
      new charts.Color(
          r: 44, g:160, b:44, a:255),
      new charts.Color(
          r: 255, g:127, b:14, a:255),
      new charts.Color(
          r: 214, g:39, b:40, a:255),
      new charts.Color(
          r: 100, g:60, b:200, a:255),
    ];
    for (var i = 0; i < data.length; i++) {
      var entry = data[i];
      print(data[i]);
      print(entry[1]);
      data_list.add(new DisabilityAge(entry[0], entry[1], colors[i]));
    }

    List<charts.Series<DisabilityAge, String>> displayData = [new charts.Series<DisabilityAge, String>(
        id: "Discapacidad",
        colorFn: (DisabilityAge disability, _) => disability.color,
        domainFn: (DisabilityAge disability, _) => disability.age,
        measureFn: (DisabilityAge disability, _) => disability.amount,
        data: data_list
    )];

    seriesList = displayData;

    var chart = new charts.BarChart(seriesList,
        animate: true,
        vertical: false);
    return Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              SizedBox(height: 20),
              new Text(
                'Cantidad de personas con discapacidad por edad',
                style: Theme.of(context).textTheme.subtitle,
              ),
              SizedBox(height: 10),
              new Text(
                '${indexSelection > -1 ? 'Edad ' + disabilityAgeData[indexSelection].data[0].age : ''}',
                style: Theme.of(context).textTheme.body2,
              ),
              SizedBox(height: 10),
              new Text(
                '${indexSelection > -1 ? disabilityAgeData[indexSelection].data[0].amount.toString() + '%': ''}',
                style: Theme.of(context).textTheme.body2,
              ),
              SizedBox(height: 20),
              new SizedBox(
                height: 400.0,
                child: chart,
              ),
            ],
          ),
        ));
      Scaffold(
      appBar: AppBar(
        title: Text("Cantidad de personas con discapacidad por edad:"),
        centerTitle: true,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            '${indexSelection > -1 ? 'Edad ' + disabilityAgeData[indexSelection].data[0].age : ''}',
            style: Theme.of(context).textTheme.body2,
          ),
          new Text(
            '${indexSelection > -1 ? disabilityAgeData[indexSelection].data[0].amount.toString() : ''}',
            style: Theme.of(context).textTheme.body2,
          ),
          Padding(
            padding: new EdgeInsets.all(32.0),
            child: new SizedBox(
              height: 200.0,
              child: chart,
            ),
          )
        ],
      ),
    );
  }
  void _infoSelectionModelUpdated(charts.SelectionModel<num> model) {
    if(model.hasDatumSelection){
      indexSelection = model.selectedSeries[0].seriesIndex;
      setState((){});
    }
  }
}

/// Sample linear data type.
class DisabilityAge {
  final int amount;
  final String age;
  final charts.Color color;

  DisabilityAge(this.age, this.amount, this.color);
}

class DisabilityAgeEntry {
  List<DisabilityAge> data;
  String ageName;

  DisabilityAgeEntry(this.ageName, this.data);
}