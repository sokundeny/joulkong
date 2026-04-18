import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:joulkong/model/station.dart';
import 'package:joulkong/ui/screens/booking/view_model/booking_view_model.dart';
import 'booking_header.dart';
import 'pass_selection.dart';
import 'bike_list.dart';
import 'booking_success.dart';

class BookingContent extends StatelessWidget {
  final Station station;

  const BookingContent({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BookingHeader(station: station),

          const SizedBox(height: 16),

          _buildBody(vm),
        ],
      ),
    );
  }

  Widget _buildBody(BookingViewModel vm) {
    switch (vm.step) {
      case BookingStep.selectPass:
        return PassSelection(vm: vm);

      case BookingStep.selectBike:
        return BikeList(vm: vm);

      case BookingStep.success:
        return BookingSuccess(vm: vm);

      case BookingStep.loadingUser:
      case BookingStep.booking:
        return const Padding(
          padding: EdgeInsets.all(30),
          child: Center(child: CircularProgressIndicator()),
        );

      case BookingStep.error:
        return Text("Error: ${vm.errorMessage}");
    }
  }
}