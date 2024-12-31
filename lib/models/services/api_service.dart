import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../utils/constants/app_constants.dart';
import '../card_group_model.dart';

abstract interface class ApiHandler {
  Future<List<CardGroup>> getCards(); // Fetch cards from the API
}

class ApiHandlerImplementation implements ApiHandler {
  final http.Client client;

  ApiHandlerImplementation({required this.client});

  @override
  Future<List<CardGroup>> getCards() async {
    try {
      // Build the API URL with query parameters
      final uri = Uri.parse(AppConstants.baseUrl).replace(
        queryParameters: {'slugs': AppConstants.slugParam},
      );

      // Make the API request with a timeout
      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(AppConstants.timeout);

      // Handle the response based on the status code
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('Empty response received'); // Handle empty responses
        }

        // Decode the JSON response and map it to CardGroup objects
        final List<dynamic> jsonDecodedData = json.decode(response.body);
        log(jsonDecodedData.runtimeType
            .toString()); // Log the data type for debugging
        return jsonDecodedData
            .map(
              (json) => CardGroup.fromJson(json), // Convert JSON to CardGroup
            )
            .toList();
      } else if (response.statusCode == 404) {
        throw Exception('Resource not found'); // Handle 404 errors
      } else if (response.statusCode >= 500) {
        throw Exception(
            'Server error: ${response.statusCode}'); // Handle server errors
      } else {
        throw Exception(
            'HTTP ${response.statusCode}: ${response.reasonPhrase}'); // Handle other HTTP errors
      }
    } on TimeoutException {
      throw Exception('Request timed out'); // Handle timeout errors
    }
  }
}
