import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'package:test_project/singleton.dart' as singleton;
void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  singleton.DataSingleton instance = singleton.DataSingleton.getInstance();
  await instance.loadByRegion();
  List<List> data = instance.byRegion;
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto Corto 1',
      home: Home()
    );
  }


}
