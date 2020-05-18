import "package:csv/csv.dart" as csv;
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<List<List>> readCsv(String csvPath) async{
  String myCsv = await rootBundle.loadString(csvPath);
  return csvToList(myCsv);
}

List<List> csvToList(String csvFile){
  csv.CsvToListConverter converter = new csv.CsvToListConverter(fieldDelimiter: ",", shouldParseNumbers: true);
  return converter.convert(csvFile);
}