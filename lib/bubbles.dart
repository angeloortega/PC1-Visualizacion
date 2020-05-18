/// Example of a scatter plot chart with a bucketing measure axis and a legend.
///
/// A bucketing measure axis positions all values beneath a certain threshold
/// into a reserved space on the axis range. The label for the bucket line will
/// be drawn in the middle of the bucket range, rather than aligned with the
/// gridline for that value's position on the scale.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'singleton.dart' as singleton;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';

class Bubbles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BubblesState();
}

class BubblesState extends State<Bubbles> {
  
  List<charts.Series> seriesList;
  String text = "";
  int indexSelection = -1;
  List<DisabilityEntry> disabilityData;
  @override
  Widget build(BuildContext context) {
    List<List> data = singleton.DataSingleton.getInstance().byRegion;
    disabilityData = [];
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
    ];
    for (var i = 0; i < data.length; i++) {
      var entry = data[i];

      disabilityData.add(new DisabilityEntry(
          entry[0], [new DisabilityRegion(entry[0], entry[1], colors[i])]));
    }

    List<charts.Series<DisabilityRegion, double>> displayData = [];

    for (var i = 0; i < disabilityData.length; i++) {
      DisabilityEntry entry = disabilityData[i];
      displayData.add(new charts.Series<DisabilityRegion, double>(
          id: entry.regionName,
          colorFn: (DisabilityRegion data, _) => data.color,
          domainFn: (DisabilityRegion data, _) => i * 2.0,
          measureFn: (DisabilityRegion data, _) =>
              data.percentage == 24 ? 16 : data.percentage,
          radiusPxFn: (DisabilityRegion data, _) => data.percentage * 2.3,
          data: entry.data));
    }
    seriesList = displayData;
    var chart = new charts.ScatterPlotChart(seriesList,
        selectionModels: [
          new charts.SelectionModelConfig(
            updatedListener: _infoSelectionModelUpdated,
            changedListener: _infoSelectionModelUpdated)
        ],
        primaryMeasureAxis: new charts.NumericAxisSpec(
            renderSpec: new charts.NoneRenderSpec(),
            tickProviderSpec: new charts.StaticNumericTickProviderSpec(
              <charts.TickSpec<num>>[
                charts.TickSpec<num>(10),
                charts.TickSpec<num>(19),
                charts.TickSpec<num>(26),
              ],
            )),
        domainAxis: new charts.NumericAxisSpec(
            renderSpec: new charts.NoneRenderSpec(),
            tickProviderSpec: new charts.StaticNumericTickProviderSpec(
              <charts.TickSpec<num>>[
                charts.TickSpec<num>(-2),
                charts.TickSpec<num>(5),
                charts.TickSpec<num>(12)
              ],
            )),

        /// This is an OrdinalAxisSpec to match up with BarChart's default
        /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
        /// other charts).

        behaviors: [
          new charts.SeriesLegend(
              position: charts.BehaviorPosition.top,
              desiredMaxColumns: 3,
              cellPadding: new EdgeInsets.only(left: 22.0, bottom: 10.0)),
        ],
        animate: true);
    return new Container(
        child: new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          SizedBox(height: 20),
          new Text(
            'Porcentaje de personas con discapacidad según región.',
            style: Theme.of(context).textTheme.subtitle,
          ),
          SizedBox(height: 20),
          new Text(
            '${indexSelection > -1 ? 'Región ' + disabilityData[indexSelection].data[0].region : ''}',
            style: Theme.of(context).textTheme.body2,
          ),
          SizedBox(height: 10),
          new Text(
            '${indexSelection > -1 ? disabilityData[indexSelection].data[0].percentage.toString() + '%': ''}',
            style: Theme.of(context).textTheme.body2,
          ),
          SizedBox(height: 20),
          new SizedBox(
            height: 500.0,
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
class DisabilityRegion {
  final double percentage;
  final String region;
  final charts.Color color;

  DisabilityRegion(this.region, this.percentage, this.color);
}

class DisabilityEntry {
  List<DisabilityRegion> data;
  String regionName;

  DisabilityEntry(this.regionName, this.data);
}
