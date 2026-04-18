
import 'package:joulkong/data/repositories/bikes/bike_repository_mock.dart';
import 'package:joulkong/data/repositories/docks/dock_repository.dart';
import 'package:joulkong/data/repositories/docks/dock_repository_mock.dart';
import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/data/repositories/stations/station_repository_mock.dart';
import 'package:joulkong/data/repositories/subscribtions/subscription_repository.dart';
import 'package:joulkong/data/repositories/subscribtions/subscription_repository_mock.dart';
import 'package:joulkong/ui/state/app_state.dart';
import 'package:provider/provider.dart';
import 'main_common.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {

  return [
    Provider<StationRepository>(create: (_) => StationRepositoryMock()),
    Provider<DockRepository>(create: (_) => DockRepositoryMock()),
    Provider<SubscriptionRepository>(create: (_)=>SubscriptionRepositoryMock()),
    ChangeNotifierProvider<AppState>(create: (_)=>AppState(repo:BikeRepositoryMock())),
    // Provider<UserRepository>(create: (_) => UserRepositoryMock()),
  ];
}

void main() {
  mainCommon(devProviders);
}
