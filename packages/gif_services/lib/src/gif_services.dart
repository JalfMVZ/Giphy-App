// ignore_for_file: public_member_api_docs, avoid_dynamic_calls, strict_raw_type
import 'dart:convert';

import 'package:http/http.dart' as http;

/// {@template gif_services}
/// My new Flutter package
/// {@endtemplate}
class GifServices {
  /// {@macro gif_services}
  GifServices({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final String baseUrl = 'api.giphy.com';
  final String endPoint = '/v1/gifs/trending';
  final String apiKey = 'CyFrb4epygMh2J5ySAnSe0WFjrQWn0Wc';

  /// Fetch GIFs asynchronously
  Future<List<String>> fetchGifs() async {
    // Changed return type to Future<void>
    final uri = Uri.http(baseUrl, endPoint, {'api_key': apiKey});
    http.Response response;
    List body;
    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw Exception('Failed to load data');
    }
    if (response.statusCode != 200) {
      throw HttpRequestException();
    }
    try {
      body = jsonDecode(response.body)['data'] as List;
    } on Exception {
      throw JsonDecodeException();
    }
    return body
        .map((url) => url['images']['original']['url'].toString())
        .toList();
  }
}

class HttpRequestException implements Exception {}

class JsonDecodeException implements Exception {}
