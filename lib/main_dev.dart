
import 'package:joulkong/data/repositories/bikes/bike_repository.dart';
import 'package:joulkong/data/repositories/bikes/bike_repository_mock.dart';
import 'package:joulkong/data/repositories/docks/dock_repository.dart';
import 'package:joulkong/data/repositories/docks/dock_repository_mock.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/data/repositories/stations/station_repository_mock.dart';
import 'package:provider/provider.dart';
import 'main_common.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {

  return [
    Provider<StationRepository>(create: (_) => StationRepositoryMock()),
    Provider<BikeRepository>(create: (_) => BikeRepositoryMock()),
    Provider<DockRepository>(create: (_) => DockRepositoryMock())
  ];
}

void main() {
  mainCommon(devProviders);
}
