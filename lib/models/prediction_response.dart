import 'crop_model.dart';

class FeatureImportance {
  final String feature;
  final double impact;

  FeatureImportance({
    required this.feature,
    required this.impact,
  });

  factory FeatureImportance.fromJson(Map<String, dynamic> json) {
    return FeatureImportance(
      feature: json["feature"],
      impact: (json["impact"] as num).toDouble(),
    );
  }
}

class PredictionResponse {
  final List<CropResult> results;
  final List<FeatureImportance> explanation;

  PredictionResponse({
    required this.results,
    required this.explanation,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      results: (json["results"] as List)
          .map((e) => CropResult.fromJson(e))
          .toList(),
      explanation: (json["explanation"] as List)
          .map((e) => FeatureImportance.fromJson(e))
          .toList(),
    );
  }
}