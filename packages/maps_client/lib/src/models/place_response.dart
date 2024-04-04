import 'package:collection/collection.dart';

import 'lat_lng.dart';

class PlaceResponse {
  final String id; // PlaceId
  final LatLng latLng;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  const PlaceResponse({
    required this.id,
    required this.latLng,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory PlaceResponse.fromJson(Map<String, dynamic> json) {
    try {
      print('Place: $json');
      // Lat/lng and PlaceId
      final placeId = json['id'] as String;
      final lat = json['location']['latitude'] as double;
      final lng = json['location']['longitude'] as double;

      // Address components
      final addressComponents = json['addressComponents'] as List<dynamic>;

      final street = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('route');
          })?['longText'] as String? ??
          '';

      final city = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('locality');
          })?['longText'] as String? ??
          '';

      final state = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('administrative_area_level_1');
          })?['longText'] as String? ??
          '';

      final postalCode = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('postal_code');
          })?['longText'] as String? ??
          '';

      final country = addressComponents.firstWhereOrNull((component) {
            final types = component['types'] as List<dynamic>;
            return types.contains('country');
          })?['long_name'] as String? ??
          '';

      return PlaceResponse(
        id: placeId,
        latLng: LatLng(lat, lng),
        street: street,
        city: city,
        state: state,
        postalCode: postalCode,
        country: country,
      );
    } catch (err) {
      throw Exception(
        'Failed to create Address from place details response: $err',
      );
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
