import 'package:flutter/services.dart';

class CropResult {
  final String name;
  final double score;

  CropResult(this.name, this.score);
}

class CSVService {
  static Future<List<CropResult>> getTopPredictions({
    required double N,
    required double P,
    required double K,
    required double temperature,
    required double humidity,
    required double ph,
    required double rainfall,
  }) async {
    final raw = await rootBundle.loadString('assets/Crop_recommendation.csv');
    final lines = raw.split('\n');
    lines.removeAt(0);

    List<CropResult> results = [];

    for (var line in lines) {
      if (line.trim().isEmpty) continue;

      final v = line.split(',');

      double score =
          (double.parse(v[0]) - N).abs() +
              (double.parse(v[1]) - P).abs() +
              (double.parse(v[2]) - K).abs() +
              (double.parse(v[3]) - temperature).abs() +
              (double.parse(v[4]) - humidity).abs() +
              (double.parse(v[5]) - ph).abs() +
              (double.parse(v[6]) - rainfall).abs();

      results.add(CropResult(v[7], score));
    }

    results.sort((a, b) => a.score.compareTo(b.score));

    return results.take(3).toList();
  }
}