import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/data/repositories/docks/dock_repository.dart';
import 'package:joulkong/model/station.dart';
import 'package:joulkong/ui/screens/station/view_model/station_view_model.dart';
import 'package:joulkong/ui/screens/station/widgets/station_content.dart';
import 'package:provider/provider.dart';

class StationScreen extends StatelessWidget {
  final Station selectedStation;

  StationScreen({required this.selectedStation});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StationViewModel(
        dockRepo: context.read<DockRepository>(),
        bikeRepo: context.read<BikeRepository>(),
        selectedStation: selectedStation
      ),
      child: StationContent(),
    );
  }
}
