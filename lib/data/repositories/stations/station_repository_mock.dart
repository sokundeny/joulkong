import 'package:joulkong/data/repositories/stations/station_repository.dart';
import 'package:joulkong/model/station.dart';

class StationRepositoryMock extends StationRepository {
  final List<Station> _stations = [
    Station(
      id: '00001',
      name: 'Central Market Area',
      latitute: 11.5685,
      longtitute: 104.9220,
    ),
    Station(
      id: '00002',
      name: 'BKK1 Station',
      latitute: 11.5528,
      longtitute: 104.9272,
    ),
    Station(
      id: '00003',
      name: 'Russian Market',
      latitute: 11.5342,
      longtitute: 104.9168,
    ),
    Station(
      id: '00004',
      name: 'Olympic Stadium',
      latitute: 11.5560,
      longtitute: 104.9155,
    ),
    Station(
      id: '00005',
      name: 'Wat Phnom Area',
      latitute: 11.5752,
      longtitute: 104.9228,
    ),

    Station(
      id: '00006',
      name: 'Tuol Kork Center',
      latitute: 11.5690,
      longtitute: 104.9055,
    ),
    Station(
      id: '00007',
      name: 'Chbar Ampov Bridge',
      latitute: 11.5205,
      longtitute: 104.9430,
    ),
    Station(
      id: '00008',
      name: 'NagaWorld Area',
      latitute: 11.5443,
      longtitute: 104.9310,
    ),
    Station(
      id: '00009',
      name: 'Royal Palace Vicinity',
      latitute: 11.5623,
      longtitute: 104.9315,
    ),
    Station(
      id: '00010',
      name: 'Koh Pich Entrance',
      latitute: 11.5458,
      longtitute: 104.9425,
    ),

    Station(
      id: '00011',
      name: 'Sen Sok Area',
      latitute: 11.6030,
      longtitute: 104.8930,
    ),
    Station(
      id: '00012',
      name: 'Toul Tom Poung Edge',
      latitute: 11.5405,
      longtitute: 104.9192,
    ),
    Station(
      id: '00013',
      name: 'Chroy Changvar Bridge',
      latitute: 11.6008,
      longtitute: 104.9350,
    ),
    Station(
      id: '00014',
      name: 'Veng Sreng Blvd',
      latitute: 11.5200,
      longtitute: 104.8955,
    ),
    Station(
      id: '00015',
      name: 'Phnom Penh Airport Area',
      latitute: 11.5466,
      longtitute: 104.8440,
    ),

    Station(
      id: '00016',
      name: 'Orussey Market',
      latitute: 11.5608,
      longtitute: 104.9180,
    ),
    Station(
      id: '00017',
      name: 'Stung Meanchey',
      latitute: 11.5295,
      longtitute: 104.9065,
    ),
    Station(
      id: '00018',
      name: 'Boeng Keng Kang High Street',
      latitute: 11.5510,
      longtitute: 104.9308,
    ),
    Station(
      id: '00019',
      name: 'Chak Angre Krom',
      latitute: 11.5098,
      longtitute: 104.9490,
    ),
    Station(
      id: '00020',
      name: 'Riverside Sisowath Quay',
      latitute: 11.5798,
      longtitute: 104.9288,
    ),
  ];

  @override
  Future<List<Station>> fetchStations() async {
    return Future.delayed(Duration(seconds: 4), () {
      return _stations;
    });
  }
}
