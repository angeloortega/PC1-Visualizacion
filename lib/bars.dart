import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/data.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class Bars extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => BarsState();

}

class BarsState extends State<Bars>{
  List<int> clicksCount = [12,24,10];
  int actualClickData = 0;

  @override
  Widget build(BuildContext context) {
    var data = [
      new ClicksPerYear('2016', clicksCount[0], Colors.red),
      new ClicksPerYear('2017', clicksCount[1], Colors.yellow),
      new ClicksPerYear('2018', clicksCount[2], Colors.green),
    ];


    var series = [
      new charts.Series(
        id: 'Clicks',
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        data: data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
      selectionModels: [
        SelectionModelConfig(
            changedListener: (SelectionModel model) {
              if(model.hasDatumSelection) {
                actualClickData = model.selectedDatum[0].index;
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text(data[actualClickData].year),
                        content: Text("Clicks made: "+data[actualClickData].clicks.toString()),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Close"),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    }
                );
                setState(() {

                });
              }
            }
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Bars"),
        centerTitle: true,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'You have pushed the button this many times:',
          ),
          new Text(
            '${clicksCount[actualClickData]}',
            style: Theme.of(context).textTheme.display1,
          ),
          Padding(
            padding: new EdgeInsets.all(32.0),
            child: new SizedBox(
              height: 200.0,
              child: chart,
            ),
          ),
          FlatButton(
            child: Icon(Icons.add),
            color: Colors.cyan,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            onPressed: (){
              setState(() {
                ++clicksCount[actualClickData];
              });
            },
          )
        ],
      ),
    );
  }
}