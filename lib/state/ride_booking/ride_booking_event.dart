part of 'ride_booking_bloc.dart';

abstract class RideBookingEvent extends Equatable {
  const RideBookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadRideBookingEvent extends RideBookingEvent {}

class UpdatePickUpAddressEvent extends RideBookingEvent {
  final LatLng latLng;

  const UpdatePickUpAddressEvent({required this.latLng});

  @override
  List<Object?> get props => [latLng];
}

class ConfirmPickUpAddressEvent extends RideBookingEvent {}

class SearchDropOffAddressEvent extends RideBookingEvent {
  final String query;

  const SearchDropOffAddressEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class SelectDropOffSuggestionEvent extends RideBookingEvent {
  final AddressSuggestion addressSuggestion;

  const SelectDropOffSuggestionEvent({required this.addressSuggestion});

  @override
  List<Object?> get props => [addressSuggestion];
}

class ConfirmDropOffAddressEvent extends RideBookingEvent {}
