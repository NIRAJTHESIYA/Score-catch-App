import 'dart:convert';
import 'package:http/http.dart' as http;

class CricketApiService {
  final String apiKey = 'YOUR_API_KEY'; // Replace with your actual API key
  final String baseUrl = 'https://cricapi.com/api/'; // Example base URL

  Future<Map<String, dynamic>> fetchLiveMatches() async {
    final response = await http.get(Uri.parse('${baseUrl}liveMatches?apikey=$apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load live matches');
    }
  }
}
