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
    try {
      throw UnimplementedError();
    } catch (err) {
      throw Exception('Failed to fetch address from coordinates: $err');
    }
  }

  Future<PlaceResponse> fetchPlaceDetails({
    required String placeId,
    List<String>? fields,
  }) async {
    try {
      throw UnimplementedError();
    } catch (err) {
      throw Exception('Failed to fetch place details: $err');
    }
  }

  Future<List<PlaceAutocompleteResponse>> fetchAutocompleteSuggestions({
    required String query,
    Map<String, dynamic>? locationBias,
  }) async {
    try {
      throw UnimplementedError();
    } catch (err) {
      throw Exception('Failed to fetch autocomplete predictions: $err');
    }
  }

  Future<DirectionResponse> fetchDirections({
    required String originId,
    required String destinationId,
  }) async {
    try {
      throw UnimplementedError();
    } catch (err) {
      throw Exception('Failed to fetch directions: $err');
    }
  }
}
