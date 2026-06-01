import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<List<dynamic>> getRestaurantList() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      return jsonData['restaurants'];
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<dynamic> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      return jsonData['restaurant'];
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}
