part of 'ride_booking_screen.dart';

class _RideBookingMap extends StatefulWidget {
  const _RideBookingMap({required this.target});

  final LatLng target;

  @override
  State<_RideBookingMap> createState() => _RideBookingMapState();
}

class _RideBookingMapState extends State<_RideBookingMap> {
  late Completer<GoogleMapController> _controller;

  CameraPosition? cameraPosition;
  bool isUpdatingCameraPosition = false;

  @override
  void initState() {
    _controller = Completer<GoogleMapController>();
    super.initState();
  }

  void toggleIcon() {
    setState(() {
      isUpdatingCameraPosition = !isUpdatingCameraPosition;
    });
  }

  void updateCameraPosition(CameraPosition position) {
    setState(() {
      cameraPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<RideBookingBloc, RideBookingState>(
      builder: (context, state) {
        Set<Polyline> polylines = {};

        if (state.directions.isNotEmpty) {
          polylines = {
            Polyline(
              polylineId: const PolylineId('route'),
              color: colorScheme.primary,
              width: 3,
              points: state.directions,
            ),
          };
        }
        return Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: widget.target,
                zoom: 14,
              ),
              polylines: polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMoveStarted: () {
                toggleIcon();
              },
              onCameraMove: (position) {
                updateCameraPosition(position);
              },
              onCameraIdle: () {
                if (isUpdatingCameraPosition) {
                  toggleIcon();
                }
                if (cameraPosition != null) {
                  context.read<RideBookingBloc>().add(
                        UpdatePickUpAddressEvent(
                          latLng: cameraPosition!.target,
                        ),
                      );
                }
              },
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: isUpdatingCameraPosition
                  ? Container(
                      width: 12.0,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withOpacity(0.5),
                            spreadRadius: 2.0,
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    )
                  : Icon(Icons.location_on,
                      size: 42.0, color: colorScheme.primary),
            ),
          ],
        );
      },
    );
  }
}
