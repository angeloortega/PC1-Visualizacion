import 'package:test_project/csv.dart' as csv;

class DataSingleton {
  List<List> segunRegion;
  List<List> segunTipo;
  List<List> segunEdad;

  //TODO agregar otros datos
  List<List> get byRegion => segunRegion;
  List<List> get byType => segunTipo;
  List<List> get byAge => segunEdad;

  void loadByRegion() async {
    segunRegion = await csv.readCsv("assets/1_personas_con_discapacidad_segun_region.csv");
  }
  void loadByType() async {
    segunTipo = await csv.readCsv("assets/2_personas_con_discapacidad_segun_tipo.csv");
  }
  void loadByAge() async {
    segunEdad = await csv.readCsv("assets/3_personas_con_discapacidad_segun_edad.csv");
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