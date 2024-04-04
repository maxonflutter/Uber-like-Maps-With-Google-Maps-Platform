part of 'ride_booking_screen.dart';

class _RideBookingChooseDropOff extends StatefulWidget {
  const _RideBookingChooseDropOff();

  @override
  State<_RideBookingChooseDropOff> createState() =>
      _RideBookingChooseDropOffState();
}

class _RideBookingChooseDropOffState extends State<_RideBookingChooseDropOff> {
  late TextEditingController pickUpAddressController;
  late TextEditingController dropOffAddressController;

  @override
  void initState() {
    pickUpAddressController = TextEditingController();
    dropOffAddressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pickUpAddressController.dispose();
    dropOffAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container();
  }
}
