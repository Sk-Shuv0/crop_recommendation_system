import 'dart:math';
import '../models/crop_model.dart';

class RecommendationService {

  String recommendCrop(
      List<CropModel> crops,
      CropModel input,
      ) {
    final normalizedCrops = _normalizeData(crops);
    final normalizedInput = _normalizeInput(crops, input);

    double minDistance = double.infinity;
    String bestCrop = "";

    for (int i = 0; i < normalizedCrops.length; i++) {
      double distance = _calculateDistance(
        normalizedCrops[i],
        normalizedInput,
      );

      if (distance < minDistance) {
        minDistance = distance;
        bestCrop = crops[i].label;
      }
    }

    return bestCrop;
  }

  List<CropModel> _normalizeData(List<CropModel> crops) {
    double minN = crops.map((e) => e.n).reduce(min);
    double maxN = crops.map((e) => e.n).reduce(max);

    double minP = crops.map((e) => e.p).reduce(min);
    double maxP = crops.map((e) => e.p).reduce(max);

    double minK = crops.map((e) => e.k).reduce(min);
    double maxK = crops.map((e) => e.k).reduce(max);

    double minTemp = crops.map((e) => e.temperature).reduce(min);
    double maxTemp = crops.map((e) => e.temperature).reduce(max);

    double minHum = crops.map((e) => e.humidity).reduce(min);
    double maxHum = crops.map((e) => e.humidity).reduce(max);

    double minPh = crops.map((e) => e.ph).reduce(min);
    double maxPh = crops.map((e) => e.ph).reduce(max);

    double minRain = crops.map((e) => e.rainfall).reduce(min);
    double maxRain = crops.map((e) => e.rainfall).reduce(max);

    return crops.map((crop) {
      return CropModel(
        n: _norm(crop.n, minN, maxN),
        p: _norm(crop.p, minP, maxP),
        k: _norm(crop.k, minK, maxK),
        temperature: _norm(crop.temperature, minTemp, maxTemp),
        humidity: _norm(crop.humidity, minHum, maxHum),
        ph: _norm(crop.ph, minPh, maxPh),
        rainfall: _norm(crop.rainfall, minRain, maxRain),
        label: crop.label,
      );
    }).toList();
  }

  CropModel _normalizeInput(List<CropModel> crops, CropModel input) {
    double minN = crops.map((e) => e.n).reduce(min);
    double maxN = crops.map((e) => e.n).reduce(max);

    double minP = crops.map((e) => e.p).reduce(min);
    double maxP = crops.map((e) => e.p).reduce(max);

    double minK = crops.map((e) => e.k).reduce(min);
    double maxK = crops.map((e) => e.k).reduce(max);

    double minTemp = crops.map((e) => e.temperature).reduce(min);
    double maxTemp = crops.map((e) => e.temperature).reduce(max);

    double minHum = crops.map((e) => e.humidity).reduce(min);
    double maxHum = crops.map((e) => e.humidity).reduce(max);

    double minPh = crops.map((e) => e.ph).reduce(min);
    double maxPh = crops.map((e) => e.ph).reduce(max);

    double minRain = crops.map((e) => e.rainfall).reduce(min);
    double maxRain = crops.map((e) => e.rainfall).reduce(max);

    return CropModel(
      n: _norm(input.n, minN, maxN),
      p: _norm(input.p, minP, maxP),
      k: _norm(input.k, minK, maxK),
      temperature: _norm(input.temperature, minTemp, maxTemp),
      humidity: _norm(input.humidity, minHum, maxHum),
      ph: _norm(input.ph, minPh, maxPh),
      rainfall: _norm(input.rainfall, minRain, maxRain),
      label: "",
    );
  }

  double _norm(double value, double min, double max) {
    return (value - min) / (max - min);
  }

  double _calculateDistance(CropModel a, CropModel b) {
    return sqrt(
      pow(a.n - b.n, 2) +
          pow(a.p - b.p, 2) +
          pow(a.k - b.k, 2) +
          pow(a.temperature - b.temperature, 2) +
          pow(a.humidity - b.humidity, 2) +
          pow(a.ph - b.ph, 2) +
          pow(a.rainfall - b.rainfall, 2),
    );
  }
}
