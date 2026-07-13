import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prediction_response.dart';

class RecommendationService {

  static const String baseUrl =
      "https://crop-recommendation-api-e11d.onrender.com";

  static Future<PredictionResponse> getPrediction({
    required double N,
    required double P,
    required double K,
    required double temperature,
    required double humidity,
    required double ph,
    required double rainfall,
  }) async {

    final response = await http.post(
      Uri.parse('$baseUrl/predict'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "N": N,
        "P": P,
        "K": K,
        "temperature": temperature,
        "humidity": humidity,
        "ph": ph,
        "rainfall": rainfall,
      }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return PredictionResponse.fromJson(json);
    } else {
      throw Exception(response.body);
    }
  }
}