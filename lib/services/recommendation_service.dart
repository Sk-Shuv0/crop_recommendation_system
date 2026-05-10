
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecommendationService {
  static const String baseUrl = "http://10.158.227.208:8000";

  static Future<String?> getPrediction({
    required double N,
    required double P,
    required double K,
    required double temperature,
    required double humidity,
    required double ph,
    required double rainfall,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/predict");

      final response = await http.post(
        url,
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

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["prediction"];
      } else {
        return null;
      }
    } catch (e) {
      print("API ERROR: $e");
      return null;
    }
  }
}