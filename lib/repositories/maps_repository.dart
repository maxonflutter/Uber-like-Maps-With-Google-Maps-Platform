import 'package:api_client/api_client.dart';
import 'package:core/entities.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsRepository {
  MapsRepository({required this.apiClient});

  final ApiClient apiClient;

  Future<Address?> fetchAddressFromUserCoordinates() async {
    try {
      throw UnimplementedError();
    } catch (err) {
      throw Exception('Failed to fetch user coordinates: $err');
    }
  }

  Future<Address> fetchAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      throw UnimplementedError();
    } catch (err) {
      throw Exception('Failed to fetch address from coordinates: $err');
    }
  }

  Future<List<AddressSuggestion>> fetchAddressSuggestions({
    required String query,
    required double latitude,
    required double longitude,
  }) async {
    try {
      throw UnimplementedError();
    } catch (err) {
      throw Exception('Failed to fetch : $err');
    }
  }

  Future<Address?> fetchAddressFromPlaceId({required String placeId}) async {
    try {
      throw UnimplementedError();
    } catch (err) {
      throw Exception('Failed to fetch address from place ID: $err');
    }
  }

  Future<List<LatLng>> fetchDirections({
    required String originId, //PlaceIds
    required String destinationId,
  }) async {
    try {
      throw UnimplementedError();
    } catch (err) {
      throw Exception('Failed to fetch address from place ID: $err');
    }
  }
}
