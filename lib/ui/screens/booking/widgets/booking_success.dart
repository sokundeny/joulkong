import 'package:flutter/material.dart';
import 'package:joulkong/main_common.dart';
import 'package:joulkong/ui/screens/booking/view_model/booking_view_model.dart';

class BookingSuccess extends StatelessWidget {
  final BookingViewModel vm;

  const BookingSuccess({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 60),
          const SizedBox(height: 6),
          Text("Bike ${vm.bookedBike?.id ?? ''} Booked",
           style: const TextStyle(decoration: TextDecoration.none)
           ),
          
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MyApp()),
            ),
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}
