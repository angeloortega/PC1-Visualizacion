import 'package:flutter/material.dart';
import 'package:test_project/bubbles.dart';
import 'pie.dart';
import 'bars.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Bubbles(),
    Pie(),
    Bars()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proyecto Corto 1'),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.bubble_chart),
            title: new Text('Búrbujas'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.pie_chart),
            title: new Text('Pie'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart), title: Text('Barras'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}
