import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../card_group_model.dart';

class ApiService {
  String apiUrl = dotenv.env['API_KEY'] ?? '';

  Future<List<CardGroup>> fetchCardGroups() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CardGroup.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load card groups');
      }
    } catch (e) {
      throw Exception('Error fetching card groups: $e');
    }
  }
}
