import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'singleton.dart' as singleton;
import 'package:charts_flutter/flutter.dart' as charts;
import 'data.dart';

class Pie extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PieState();

}

class PieState extends State<Pie>{

  List<charts.Series> seriesList;
  String text = "";
  int indexSelection = -1;
  List<DisabilityTypeEntry> disabilityTypeData;

  @override
  Widget build(BuildContext context) {
    List<List> data = singleton.DataSingleton.getInstance().byType;
    List<DisabilityType> data_list = [];
    disabilityTypeData = [];
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
      data_list.add(new DisabilityType(entry[0], entry[1], colors[i]));
    }


    List<charts.Series<DisabilityType, String>> displayData = [new charts.Series<DisabilityType, String>(
      id: "Discapacidad",
      colorFn: (DisabilityType disability, _) => disability.color,
      domainFn: (DisabilityType disability, _) => disability.type,
      measureFn: (DisabilityType disability, _) => disability.amount,
      data: data_list
    )];

    seriesList = displayData;

    var chart = new charts.PieChart(seriesList,
        animate: true,
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 150),
        behaviors: [
          new charts.DatumLegend(
            position: charts.BehaviorPosition.top, 
            desiredMaxColumns: 2,
            cellPadding: new EdgeInsets.only(left: 20.0, bottom: 10.0)),
        ],
    );
    return Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              SizedBox(height: 20),
              new Text(
                'Cantidad de personas por tipo de discapacidad.',
                style: Theme.of(context).textTheme.subtitle,
              ),
              SizedBox(height: 10),
              new Text(
                '${indexSelection > -1 ? 'Tipo ' + disabilityTypeData[indexSelection].data[0].type : ''}',
                style: Theme.of(context).textTheme.body2,
              ),
              SizedBox(height: 10),
              new Text(
                '${indexSelection > -1 ? disabilityTypeData[indexSelection].data[0].amount.toString() + '%': ''}',
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

  }
  void _infoSelectionModelUpdated(charts.SelectionModel<num> model) {
    if(model.hasDatumSelection){
      indexSelection = model.selectedSeries[0].seriesIndex;
      setState((){});
    }
  }
}

/// Sample linear data type.
class DisabilityType {
  final int amount;
  final String type;
  final Color color;

  DisabilityType(this.type, this.amount, this.color);
}

class DisabilityTypeEntry {
  List<DisabilityType> data;
  String typeName;

  DisabilityTypeEntry(this.typeName, this.data);
}