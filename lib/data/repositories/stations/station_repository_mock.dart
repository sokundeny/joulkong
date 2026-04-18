import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/model/bike.dart';
import 'package:joulkong/model/station.dart';

class StationRepositoryMock extends StationRepository {
  final List<Station> _stations = [
    Station(
      id: '00001',
      name: 'Central Market Area',
      latitute: 11.5685,
      longtitute: 104.9220,
      bikes: [Bike(id: 'JK-001'), Bike(id: 'JK-002'), Bike(id: 'JK-003')],
    ),
    Station(
      id: '00002',
      name: 'BKK1 Station',
      latitute: 11.5528,
      longtitute: 104.9272,
      bikes: [Bike(id: 'JK-004'), Bike(id: 'JK-005')],
    ),
    Station(
      id: '00003',
      name: 'Russian Market',
      latitute: 11.5342,
      longtitute: 104.9168,
      bikes: [Bike(id: 'JK-006'), Bike(id: 'JK-007'), Bike(id: 'JK-008')],
    ),
    Station(
      id: '00004',
      name: 'Olympic Stadium',
      latitute: 11.5560,
      longtitute: 104.9155,
      bikes: [Bike(id: 'JK-009')],
    ),
    Station(
      id: '00005',
      name: 'Wat Phnom Area',
      latitute: 11.5752,
      longtitute: 104.9228,
      bikes: [Bike(id: 'JK-010'), Bike(id: 'JK-011')],
    ),
    Station(
      id: '00006',
      name: 'Tuol Kork Center',
      latitute: 11.5690,
      longtitute: 104.9055,
      bikes: [Bike(id: 'JK-012'), Bike(id: 'JK-013')],
    ),
    Station(
      id: '00007',
      name: 'Chbar Ampov Bridge',
      latitute: 11.5205,
      longtitute: 104.9430,
      bikes: [],
    ),
    Station(
      id: '00008',
      name: 'NagaWorld Area',
      latitute: 11.5443,
      longtitute: 104.9310,
      bikes: [Bike(id: 'JK-014'), Bike(id: 'JK-015')],
    ),
    Station(
      id: '00009',
      name: 'Royal Palace Vicinity',
      latitute: 11.5623,
      longtitute: 104.9315,
      bikes: [Bike(id: 'JK-016')],
    ),
    Station(
      id: '00010',
      name: 'Koh Pich Entrance',
      latitute: 11.5458,
      longtitute: 104.9425,
      bikes: [Bike(id: 'JK-017'), Bike(id: 'JK-018')],
    ),
    Station(
      id: '00011',
      name: 'Sen Sok Area',
      latitute: 11.6030,
      longtitute: 104.8930,
      bikes: [Bike(id: 'JK-019'), Bike(id: 'JK-020')],
    ),
    Station(
      id: '00012',
      name: 'Toul Tom Poung Edge',
      latitute: 11.5405,
      longtitute: 104.9192,
      bikes: [Bike(id: 'JK-021')],
    ),
    Station(
      id: '00013',
      name: 'Chroy Changvar Bridge',
      latitute: 11.6008,
      longtitute: 104.9350,
      bikes: [Bike(id: 'JK-022'), Bike(id: 'JK-023')],
    ),
    Station(
      id: '00014',
      name: 'Veng Sreng Blvd',
      latitute: 11.5200,
      longtitute: 104.8955,
      bikes: [],
    ),
    Station(
      id: '00015',
      name: 'Phnom Penh Airport Area',
      latitute: 11.5466,
      longtitute: 104.8440,
      bikes: [Bike(id: 'JK-024')],
    ),
    Station(
      id: '00016',
      name: 'Orussey Market',
      latitute: 11.5608,
      longtitute: 104.9180,
      bikes: [Bike(id: 'JK-025'), Bike(id: 'JK-026')],
    ),
    Station(
      id: '00017',
      name: 'Stung Meanchey',
      latitute: 11.5295,
      longtitute: 104.9065,
      bikes: [Bike(id: 'JK-027')],
    ),
    Station(
      id: '00018',
      name: 'Boeng Keng Kang High Street',
      latitute: 11.5510,
      longtitute: 104.9308,
      bikes: [Bike(id: 'JK-028'), Bike(id: 'JK-029')],
    ),
    Station(
      id: '00019',
      name: 'Chak Angre Krom',
      latitute: 11.5098,
      longtitute: 104.9490,
      bikes: [],
    ),
    Station(
      id: '00020',
      name: 'Riverside Sisowath Quay',
      latitute: 11.5798,
      longtitute: 104.9288,
      bikes: [Bike(id: 'JK-030'), Bike(id: 'JK-031')],
    ),
  ];

  @override
  Future<List<Station>> fetchStations() async {
    return Future.delayed(const Duration(seconds: 1), () => _stations);
  }

  Future<void> bookBike(String stationId, String bikeId) async {
    final station = _stations.firstWhere((s) => s.id == stationId);
    final bike = station.bikes.firstWhere((b) => b.id == bikeId);
  }
}