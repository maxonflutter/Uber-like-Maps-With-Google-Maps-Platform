import 'package:core/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../repositories/maps_repository.dart';

part 'ride_booking_event.dart';
part 'ride_booking_state.dart';

class RideBookingBloc extends Bloc<RideBookingEvent, RideBookingState> {
  final MapsRepository _mapsRepository;

  RideBookingBloc({
    required MapsRepository mapsRepository,
  })  : _mapsRepository = mapsRepository,
        super(const RideBookingState()) {
    on<LoadRideBookingEvent>(_onLoadRideBooking);
    on<UpdatePickUpAddressEvent>(_onUpdatePickUpAddress);
    on<ConfirmPickUpAddressEvent>(_onConfirmPickUpAddress);
    on<SearchDropOffAddressEvent>(_onSearchDropOffAddress);
    on<SelectDropOffSuggestionEvent>(_onSelectDropOffSuggestion);
    on<ConfirmDropOffAddressEvent>(_onConfirmDropOffAddress);
  }

  void _onLoadRideBooking(
    LoadRideBookingEvent event,
    Emitter<RideBookingState> emit,
  ) async {
    emit(state.copyWith(status: RideBookingStatus.loading));
    try {
      final address = await _mapsRepository.fetchAddressFromUserCoordinates();
      print('Address: $address');
      emit(
        state.copyWith(
          pickUpAddress: address,
          pickUpAddressSelected: true,
          status: RideBookingStatus.loaded,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: RideBookingStatus.error));
    }
  }

  void _onUpdatePickUpAddress(
    UpdatePickUpAddressEvent event,
    Emitter<RideBookingState> emit,
  ) async {
    try {
      final address = await _mapsRepository.fetchAddressFromCoordinates(
        latitude: event.latLng.latitude,
        longitude: event.latLng.longitude,
      );

      emit(
        state.copyWith(
          pickUpAddress: address,
          pickUpAddressSelected: true,
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(
          status: RideBookingStatus.error,
          pickUpAddressSelected: false,
        ),
      );
    }
  }

  _onConfirmPickUpAddress(
    ConfirmPickUpAddressEvent event,
    Emitter<RideBookingState> emit,
  ) {
    emit(state.copyWith(pickUpAddressConfirmed: true));
  }

  void _onSearchDropOffAddress(
    SearchDropOffAddressEvent event,
    Emitter<RideBookingState> emit,
  ) async {
    try {
      final suggestions = await _mapsRepository.fetchAddressSuggestions(
        query: event.query,
        latitude: state.pickUpAddress!.latLng!.latitude,
        longitude: state.pickUpAddress!.latLng!.longitude,
      );
      print(suggestions);
      emit(state.copyWith(searchResultsForDropOff: suggestions));
    } catch (err) {
      emit(state.copyWith(status: RideBookingStatus.error));
    }
  }

  void _onSelectDropOffSuggestion(
    SelectDropOffSuggestionEvent event,
    Emitter<RideBookingState> emit,
  ) async {
    try {
      final address = await _mapsRepository.fetchAddressFromPlaceId(
        placeId: event.addressSuggestion.id,
      );

      if (address == null) {
        emit(state.copyWith(status: RideBookingStatus.error));
      } else {
        emit(
          state.copyWith(
            dropOffAddress: address,
            searchResultsForDropOff: [],
            dropOffAddressSelected: true,
          ),
        );
      }
    } catch (err) {
      emit(
        state.copyWith(
          status: RideBookingStatus.error,
          dropOffAddressSelected: false,
        ),
      );
    }
  }

  void _onConfirmDropOffAddress(
    ConfirmDropOffAddressEvent event,
    Emitter<RideBookingState> emit,
  ) async {
    try {
      final directions = await _mapsRepository.fetchDirections(
        originId: state.pickUpAddress!.id,
        destinationId: state.dropOffAddress!.id,
      );

      emit(
        state.copyWith(
          dropOffAddressConfirmed: true,
          directions: directions,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: RideBookingStatus.error));
    }
  }
}
