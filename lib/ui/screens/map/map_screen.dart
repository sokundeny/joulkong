import 'package:flutter/material.dart';
import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/data/repositories/docks/dock_repository.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/ui/screens/map/view_model/map_view_model.dart';
import 'package:joulkong/ui/screens/map/widgets/map_content.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapViewModel(
        stationRepo: context.read<StationRepository>(),
        dockRepo: context.read<DockRepository>(),
        bikeRepo: context.read<BikeRepository>()
      ),
      child: MapContent(),  
    );
  }
}
