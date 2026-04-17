import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:joulkong/model/station.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/data/repositories/user/user_repository.dart';
import 'package:joulkong/ui/screens/booking/view_model/booking_view_model.dart';
import 'package:joulkong/ui/screens/booking/widgets/booking_content.dart';

class BookingScreen extends StatelessWidget {
  final Station station;

  const BookingScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingViewModel(
        stationRepo: context.read<StationRepository>(),
        userRepo: context.read<UserRepository>(),
        station: station,
      ),
      child: BookingContent(station: station),
    );
  }
}