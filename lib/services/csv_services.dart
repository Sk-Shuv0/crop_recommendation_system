import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import '../models/crop_model.dart';

class CsvService {

  Future<List<CropModel>> loadCrops() async {
    final rawData = await rootBundle.loadString('assets/Crop_recommendation.csv');

    List<List<dynamic>> csvTable =
    const CsvToListConverter().convert(rawData);

    List<CropModel> crops = [];

    for (int i = 1; i < csvTable.length; i++) {
      crops.add(CropModel.fromList(csvTable[i]));
    }

    return crops;
  }
}
