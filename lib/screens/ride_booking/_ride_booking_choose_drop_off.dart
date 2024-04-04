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

    return BlocBuilder<RideBookingBloc, RideBookingState>(
      builder: (context, state) {
        pickUpAddressController.text =
            '${state.pickUpAddress?.city ?? ''} ${state.pickUpAddress?.street ?? ''}';

        if (state.dropOffAddressSelected) {
          dropOffAddressController.text =
              '${state.dropOffAddress?.city ?? ''} ${state.dropOffAddress?.street ?? ''}';
        }
        return Container(
          height: size.height * 0.8,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8.0),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Text(
                  'Set your destination',
                  style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Type and pick from the suggestions',
                  style: textTheme.bodyLarge,
                ),
                Divider(height: 32.0),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 8.0,
                          width: 8.0,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 40.0,
                          width: 2.0,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                          ),
                        ),
                        Container(
                          height: 8.0,
                          width: 8.0,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(color: colorScheme.primary),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            readOnly: true,
                            controller: pickUpAddressController,
                            decoration: const InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          TextFormField(
                            controller: dropOffAddressController,
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: 'Where to?',
                              prefixIcon: Icon(Icons.search),
                            ),
                            onChanged: (String value) {
                              // TODO: DEBOUNCE

                              context.read<RideBookingBloc>().add(
                                    SearchDropOffAddressEvent(query: value),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                // List of suggestions
                Expanded(
                  child: ListView.builder(
                    itemCount: state.searchResultsForDropOff.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          context.read<RideBookingBloc>().add(
                                SelectDropOffSuggestionEvent(
                                  addressSuggestion:
                                      state.searchResultsForDropOff[index],
                                ),
                              );
                        },
                        leading: const Icon(Icons.location_on),
                        title: Text(
                          state.searchResultsForDropOff[index].text,
                          style: textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 1,
                              margin: const EdgeInsets.only(top: 8.0),
                              color: colorScheme.surfaceVariant,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Button to confirm
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48.0),
                  ),
                  onPressed: () {
                    context.read<RideBookingBloc>().add(
                          ConfirmDropOffAddressEvent(),
                        );
                  },
                  child: const Text('Confirm destination'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
