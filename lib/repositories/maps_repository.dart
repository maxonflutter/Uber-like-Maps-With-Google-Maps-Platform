import 'package:api_client/api_client.dart';
import 'package:core/entities.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsRepository {
  MapsRepository({required this.apiClient});

  final ApiClient apiClient;

  Future<Address?> fetchAddressFromUserCoordinates() async {
    LocationPermission permission;
    try {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final addressData =
          await apiClient.mapsResource.fetchAddressFromCoordinates(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );

      return Address.fromJson(addressData['address']);
    } catch (err) {
      throw Exception('Failed to fetch user coordinates: $err');
    }
  }

  Future<Address> fetchAddressFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final addressData =
          await apiClient.mapsResource.fetchAddressFromCoordinates(
        latitude: latitude.toString(),
        longitude: longitude.toString(),
      );

      return Address.fromJson(addressData['address']);
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
      if (query.isEmpty) {
        return [];
      }
      final payload = {
        'query': query,
        'latitude': latitude,
        'longitude': longitude,
      };

      final suggestionsData =
          await apiClient.mapsResource.postAutocompleteSuggestionsRequest(
        data: payload,
      );

      return (suggestionsData['suggestions'] as List)
          .map((suggestion) => AddressSuggestion.fromJson(suggestion))
          .toList();
    } catch (err) {
      throw Exception('Failed to fetch : $err');
    }
  }

  Future<Address?> fetchAddressFromPlaceId({required String placeId}) async {
    try {
      final placeData = await apiClient.mapsResource.fetchPlaceDetails(
        placeId: placeId,
      );

      return Address.fromJson(placeData['place']);
    } catch (err) {
      throw Exception('Failed to fetch address from place ID: $err');
    }
  }

  Future<List<LatLng>> fetchDirections({
    required String originId, //PlaceIds
    required String destinationId,
  }) async {
    try {
      final directionsData = await apiClient.mapsResource.postDirectionsRequest(
        originId: originId,
        destinationId: destinationId,
      );
      return directionsData['directions']['route']
          .map(
            (direction) {
              return LatLng(
                direction['latitude'],
                direction['longitude'],
              );
            },
          )
          .toList()
          .cast<LatLng>();
    } catch (err) {
      throw Exception('Failed to fetch address from place ID: $err');
    }
  }
}
