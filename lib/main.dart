import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories/maps_repository.dart';
import 'screens/ride_booking/ride_booking_screen.dart';

const IOS_SIMULATOR_BASE_URL = 'http://localhost:8080';
const ANDROID_EMULATOR_BASE_URL = 'http://10.0.2.2:8080';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final ApiClient apiClient = ApiClient(baseUrl: IOS_SIMULATOR_BASE_URL);
  final MapsRepository mapsRepository = MapsRepository(apiClient: apiClient);

  runApp(MyApp(mapsRepository: mapsRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.mapsRepository});

  final MapsRepository mapsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: mapsRepository,
      child: MaterialApp(
        title: 'Uber-like Maps with Flutter and Google Maps Platform',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
        home: const RideBookingScreen(),
      ),
    );
  }
}
