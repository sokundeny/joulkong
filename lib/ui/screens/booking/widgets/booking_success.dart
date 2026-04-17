import 'package:flutter/material.dart';
import 'package:joulkong/ui/screens/booking/view_model/booking_view_model.dart';

class BookingSuccess extends StatelessWidget {
  final BookingViewModel vm;

  const BookingSuccess({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 60),
        const SizedBox(height: 12),
        const Text(
          "Bike Booked!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text("Bike ${vm.bookedBike?.id ?? ''} reserved"),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Done"),
        ),
      ],
    );
  }
}