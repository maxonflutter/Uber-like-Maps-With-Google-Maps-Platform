import 'package:collection/collection.dart';

import 'lat_lng.dart';

class ReverseGeocodingResponse {
  final String id; // PlaceId
  final LatLng latLng;

  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  const ReverseGeocodingResponse({
    required this.id,
    required this.latLng,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory ReverseGeocodingResponse.fromJson(Map<String, dynamic> json) {
    try {
      final results = json['results'] as List<dynamic>;
      final firstResult = results.first as Map<String, dynamic>;

      // Lat/lng and PlaceId
      final placeId = firstResult['place_id'] as String;
      final lat = firstResult['geometry']['location']['lat'] as double;
      final lng = firstResult['geometry']['location']['lng'] as double;

      // Address components
      final addressComponents =
          firstResult['address_components'] as List<dynamic>;

      final street = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('route');
          })?['long_name'] as String? ??
          '';

      final city = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('locality');
          })?['long_name'] as String? ??
          '';

      final state = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('administrative_area_level_1');
          })?['short_name'] as String? ??
          '';

      final postalCode = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('postal_code');
          })?['long_name'] as String? ??
          '';

      final country = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('country');
          })?['long_name'] as String? ??
          '';

      return ReverseGeocodingResponse(
        id: placeId,
        latLng: LatLng(lat, lng),
        street: street,
        city: city,
        state: state,
        postalCode: postalCode,
        country: country,
      );
    } catch (err) {
      throw Exception('Failed to create the ReverseGeocodingResponse: $err');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latLng': {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      },
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }
}
