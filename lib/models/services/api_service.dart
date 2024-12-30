import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../utils/constants/app_constants.dart';
import '../card_group_model.dart';

abstract interface class ApiHandler {
  Future<List<CardGroup>> getCards();
}

class ApiHandlerImplementation implements ApiHandler {
  final http.Client client;

  ApiHandlerImplementation({required this.client});

  @override
  Future<List<CardGroup>> getCards() async {
    try {
      final uri = Uri.parse(ApiConstants.baseUrl).replace(
        queryParameters: {'slugs': 'famx-paypage'},
      );

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('Empty response received');
        }

        final List<dynamic> jsonDecodedData = json.decode(response.body);
        log(jsonDecodedData.runtimeType.toString());
        return jsonDecodedData
            .map(
              (json) => CardGroup.fromJson(json),
            )
            .toList();
      } else if (response.statusCode == 404) {
        throw Exception('Resource not found');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error: ${response.statusCode}');
      } else {
        throw Exception(
            'HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } on TimeoutException {
      throw Exception();
    }
  }
}
