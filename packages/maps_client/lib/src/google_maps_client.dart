import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maps_client/src/models/models.dart';

class GoogleMapsClient {
  static const geocodingUrl = 'https://maps.googleapis.com/maps/api/geocode';
  static const placesUrl = 'https://places.googleapis.com/v1/places';
  static const routesUrl = 'https://routes.googleapis.com/directions';

  final String apiKey;
  final http.Client _httpClient;

  GoogleMapsClient({
    required this.apiKey,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Future<ReverseGeocodingResponse> latLonToAddress({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse('$geocodingUrl/json').replace(
      queryParameters: {
        'key': apiKey,
        'latlng': '$latitude,$longitude',
      },
    );
    try {
      final response = await _httpClient.get(uri);
      if (response.statusCode != 200) throw Exception();
      final responseJson = jsonDecode(response.body);
      return ReverseGeocodingResponse.fromJson(responseJson);
    } catch (err) {
      throw Exception('Failed to fetch address from coordinates: $err');
    }
  }

  Future<PlaceResponse> fetchPlaceDetails({
    required String placeId,
    List<String>? fields,
  }) async {
    final List<String> defaultFields = [
      'id',
      'displayName',
      'addressComponents',
      'location',
      'formattedAddress',
      'adrFormatAddress',
    ];

    fields ??= defaultFields;

    final uri = Uri.parse('$placesUrl/$placeId').replace(
      queryParameters: {
        'key': apiKey,
        'fields': fields.join(','),
      },
    );
    try {
      final response = await _httpClient.get(uri);
      if (response.statusCode != 200) throw Exception();
      final responseJson = jsonDecode(response.body);
      return PlaceResponse.fromJson(responseJson);
    } catch (err) {
      throw Exception('Failed to fetch place details: $err');
    }
  }

  Future<List<PlaceAutocompleteResponse>> fetchAutocompleteSuggestions({
    required String query,
    Map<String, dynamic>? locationBias,
  }) async {
    final uri = Uri.parse('$placesUrl:autocomplete');
    try {
      final response = await _httpClient.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "X-Goog-Api-Key": apiKey,
        },
        body: jsonEncode(
          {
            'input': query,
            if (locationBias != null) 'locationBias': locationBias,
          },
        ),
      );

      if (response.statusCode != 200) throw Exception();
      final responseJson = jsonDecode(response.body);
      return responseJson['suggestions']
          .map((suggestion) => PlaceAutocompleteResponse.fromJson(suggestion))
          .cast<PlaceAutocompleteResponse>()
          .toList();
    } catch (err) {
      throw Exception('Failed to fetch autocomplete predictions: $err');
    }
  }

  Future<DirectionResponse> fetchDirections({
    required String originId,
    required String destinationId,
  }) async {
    final uri = Uri.parse('$routesUrl/v2:computeRoutes');
    try {
      final response = await _httpClient.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "X-Goog-Api-Key": apiKey,
          "X-Goog-FieldMask":
              "routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline,routes.legs.steps.start_location,routes.legs.steps.end_location"
        },
        body: jsonEncode({
          'origin': {'placeId': originId},
          'destination': {'placeId': destinationId},
        }),
      );

      if (response.statusCode != 200) throw Exception();
      final responseJson = jsonDecode(response.body);
      return DirectionResponse.fromJson(responseJson);
    } catch (err) {
      throw Exception('Failed to fetch directions: $err');
    }
  }
}
