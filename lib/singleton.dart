import 'package:test_project/csv.dart' as csv;

class DataSingleton {
  List<List> segunRegion;
  //TODO agregar otros datos
  List<List> get byRegion => segunRegion;

  void loadByRegion() async {
    segunRegion = await csv.readCsv("assets/1_personas_con_discapacidad_segun_region.csv");
  }

  static DataSingleton _instance;

  DataSingleton._internal(){

  }

  static DataSingleton getInstance() {
    if (_instance == null) {
      _instance = DataSingleton._internal();
    }

    return _instance;
  }
}