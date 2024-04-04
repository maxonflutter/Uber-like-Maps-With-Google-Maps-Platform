import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../repositories/maps_repository.dart';
import '../../state/ride_booking/ride_booking_bloc.dart';

part '_ride_booking_choose_drop_off.dart';
part '_ride_booking_choose_pick_up.dart';
part '_ride_booking_map.dart';

class RideBookingScreen extends StatelessWidget {
  const RideBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RideBookingBloc(
        mapsRepository: context.read<MapsRepository>(),
      )..add(LoadRideBookingEvent()),
      child: const RideBookingView(),
    );
  }
}

class RideBookingView extends StatelessWidget {
  const RideBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [],
      ),
    );
  }
}
