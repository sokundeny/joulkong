
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
    Provider<SubscriptionRepository>(create: (_)=>SubscriptionRepositoryMock()),
    ChangeNotifierProvider<AppState>(create: (_)=>AppState())
  ];
}

void main() {
  mainCommon(devProviders);
}
