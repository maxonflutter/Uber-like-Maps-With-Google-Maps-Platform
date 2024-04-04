import 'dart:convert';

import 'package:api_client/api_client.dart';

/// An api resource to interact with the Google Maps Platform.
class MapsResource {
  MapsResource({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// [GET] /api/v1/maps/reverse-geocode
  Future<Map<String, dynamic>> fetchAddressFromCoordinates({
    required String latitude,
    required String longitude,
  }) async {
    final response = await _apiClient.get(
      '/api/v1/maps/reverse-geocode',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
      },
    );
    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return {'address': json['address']};
    } catch (err) {
      throw Exception();
    }
  }

  /// [GET] /api/v1/maps/place
  Future<Map<String, dynamic>> fetchPlaceDetails({
    required String placeId,
  }) async {
    try {
      final response = await _apiClient.get(
        '/api/v1/maps/places',
        queryParameters: {'placeId': placeId},
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return {'place': json['place']};
    } catch (err) {
      throw Exception();
    }
  }

  /// [POST] /api/v1/maps/autocomplete
  Future<Map<String, dynamic>> postAutocompleteSuggestionsRequest({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _apiClient.post(
        '/api/v1/maps/autocomplete',
        body: jsonEncode(data),
      );
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return {'suggestions': json['suggestions']};
    } catch (err) {
      throw Exception();
    }
  }

  /// [POST] /api/v1/maps/autocomplete
  Future<Map<String, dynamic>> postDirectionsRequest({
    required String originId,
    required String destinationId,
  }) async {
    final response = await _apiClient.post(
      '/api/v1/maps/routes',
      body: jsonEncode({
        'originId': originId,
        'destinationId': destinationId,
      }),
    );

    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return {'directions': json['directions']};
    } catch (err) {
      throw Exception();
    }
  }
}
