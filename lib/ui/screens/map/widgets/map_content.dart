import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:joulkong/model/station.dart';
import 'package:joulkong/ui/screens/map/view_model/map_view_model.dart';
import 'package:joulkong/ui/screens/map/widgets/station_marker.dart';
import 'package:joulkong/ui/screens/station/station_screen.dart';
import 'package:joulkong/ui/utils/animations_util.dart';
import 'package:joulkong/ui/utils/async_value.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  final String API_KEY = '';
  @override
  Widget build(BuildContext context) {
    MapViewModel mv = context.watch<MapViewModel>();
    AsyncValue<List<Station>> asyncValue = mv.data;
    Widget content = const Center(child: Text('No State'));

    switch (asyncValue.state) {
      case AsyncValueState.loading:
        content = Center(child: CircularProgressIndicator());
        break;

      case AsyncValueState.error:
        content = Center(
          child: Text(
            'error = ${asyncValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );
        break;

      case AsyncValueState.success:
        List<Station> stations = asyncValue.data!;

        final markers = stations.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final station = entry.value;

          return Marker(
            point: LatLng(station.latitute, station.longtitute),
            width: 50,
            height: 70,
            child: StationMarker( 
              number: index,
              onTap: () {
                debugPrint('Tapped: ${station.name}');
                Navigator.of(context).push(
                  AnimationUtils.createRightToLeftRoute(
                    StationScreen(selectedStation: station),
                  ),
                );
              },
            ),
          );
        }).toList();

        content = FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(11.5564, 104.9282),
            initialZoom: 16,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}.png?api_key=$API_KEY',
              userAgentPackageName: 'JoulKongApp',
            ),

            MarkerLayer(markers: markers),
          ],
        );
        break;
    }

    return Scaffold(body: content);
  }
}
