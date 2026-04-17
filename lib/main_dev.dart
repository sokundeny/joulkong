
import 'package:provider/provider.dart';
import 'main_common.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {

  return [
  ];
}

void main() {
  mainCommon(devProviders);
}
