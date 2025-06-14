import 'dart:convert';
import 'package:http/http.dart' as http;

class PredictionService {
  // API endpoint (replace with the deployed API URL)
  static const String apiUrl = 'http://172.20.1.178:5000/predict'; // Use 10.0.2.2 for Android Emulator

  static Future<Map<String, dynamic>> predict(List<double> features) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'features': features}),
      );

      if (response.statusCode == 200) {
        // Decode the response to get prediction and probabilities
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load prediction. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in prediction: $e');
    }
  }
}
