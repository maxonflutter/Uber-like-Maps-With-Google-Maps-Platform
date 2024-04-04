import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../converters/lat_lng_converter.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  const Address._();

  const factory Address({
    required String id,
    required String street,
    required String city,
    required String state,
    required String postalCode,
    required String country,
    @LatLngConverter() LatLng? latLng,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
