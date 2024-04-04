part of 'ride_booking_screen.dart';

class _RideBookingChoosePickUp extends StatefulWidget {
  const _RideBookingChoosePickUp();

  @override
  State<_RideBookingChoosePickUp> createState() =>
      _RideBookingChoosePickUpState();
}

class _RideBookingChoosePickUpState extends State<_RideBookingChoosePickUp> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container();
  }
}
