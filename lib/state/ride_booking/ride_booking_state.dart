part of 'ride_booking_bloc.dart';

enum RideBookingStatus { initial, loading, loaded, error }

class RideBookingState extends Equatable {
  final RideBookingStatus status;
  final Address? pickUpAddress;
  final Address? dropOffAddress;
  final bool pickUpAddressSelected;
  final bool pickUpAddressConfirmed;
  final bool dropOffAddressSelected;
  final bool dropOffAddressConfirmed;
  final List<AddressSuggestion> searchResultsForDropOff;
  final List<LatLng> directions;

  const RideBookingState({
    this.status = RideBookingStatus.initial,
    this.pickUpAddress,
    this.pickUpAddressSelected = false,
    this.pickUpAddressConfirmed = false,
    this.dropOffAddress,
    this.dropOffAddressSelected = false,
    this.dropOffAddressConfirmed = false,
    this.searchResultsForDropOff = const [],
    this.directions = const [],
  });

  RideBookingState copyWith({
    RideBookingStatus? status,
    Address? pickUpAddress,
    bool? pickUpAddressSelected,
    bool? pickUpAddressConfirmed,
    Address? dropOffAddress,
    bool? dropOffAddressSelected,
    bool? dropOffAddressConfirmed,
    List<AddressSuggestion>? searchResultsForDropOff,
    List<LatLng>? directions,
  }) {
    return RideBookingState(
      status: status ?? this.status,
      pickUpAddress: pickUpAddress ?? this.pickUpAddress,
      pickUpAddressSelected:
          pickUpAddressSelected ?? this.pickUpAddressSelected,
      pickUpAddressConfirmed:
          pickUpAddressConfirmed ?? this.pickUpAddressConfirmed,
      dropOffAddress: dropOffAddress ?? this.dropOffAddress,
      dropOffAddressSelected:
          dropOffAddressSelected ?? this.dropOffAddressSelected,
      dropOffAddressConfirmed:
          dropOffAddressConfirmed ?? this.dropOffAddressConfirmed,
      searchResultsForDropOff:
          searchResultsForDropOff ?? this.searchResultsForDropOff,
      directions: directions ?? this.directions,
    );
  }

  @override
  List<Object?> get props => [
        status,
        pickUpAddress,
        pickUpAddressSelected,
        pickUpAddressConfirmed,
        dropOffAddress,
        dropOffAddressSelected,
        dropOffAddressConfirmed,
        searchResultsForDropOff,
        directions,
      ];
}
