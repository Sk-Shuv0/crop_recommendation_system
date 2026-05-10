import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crop_model.dart';

class RFService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<List<CropResult>> getPrediction({
    required double N,
    required double P,
    required double K,
    required double temperature,
    required double humidity,
    required double ph,
    required double rainfall,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/predict"),
        headers: {"Content-Type": "application/json"},
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

      print("Status: ${res.statusCode}");
      print("Body: ${res.body}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        // if (data["results"] == null) {
        //   throw Exception("No results key");
        // }

        List list = data["results"];

        return list.map((e) => CropResult.fromJson(e)).toList();
      } else {
        throw Exception("Server error ${res.statusCode}");
      }
    } catch (e) {
      print("API ERROR: $e");
      rethrow;
    }
  }
}