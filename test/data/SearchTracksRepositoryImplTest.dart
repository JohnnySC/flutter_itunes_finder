import 'package:connectivity/connectivity.dart';
import 'package:itunes_finder/data/Exceptions.dart';
import 'package:itunes_finder/data/SearchTracksRepositoryImpl.dart';
import 'package:itunes_finder/data/SearchTracksService.dart';
import 'package:itunes_finder/data/TrackList.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  Connectivity connectivity = MockConnectivity();
  SearchTracksService service = MockService();
  SearchTracksRepositoryImpl repository =
      SearchTracksRepositoryImpl(connectivity, service);

  test('test no connectivity case', () {
    when(connectivity.checkConnectivity())
        .thenAnswer((_) => _getNoConnectivityFuture());
    expect(repository.fetchTracksList("nomatter"),
        throwsA(predicate((e) => e is NoConnectionException)));
  });

  test('test service is unavailable case', () {
    when(connectivity.checkConnectivity())
        .thenAnswer((_) => _getConnectivityFuture());
    when(service.searchTracks(any))
        .thenAnswer((_) => _getServiceUnavailableFuture());
    expect(repository.fetchTracksList("some"),
        throwsA(predicate((e) => e is ServiceUnavailableException)));
  });

  test('test service returns a good answer case', () async {
    when(connectivity.checkConnectivity())
        .thenAnswer((_) => _getConnectivityFuture());
    when(service.searchTracks(any))
        .thenAnswer((_) => _getServiceGoodAnswerFuture());

    TrackList actual = await repository.fetchTracksList("any");
    var expected = _getExpectedTrackList();
    expect(actual.toString(), equals(expected.toString()));
  });
}

TrackList _getExpectedTrackList() {
  Track track = Track();
  track.artistName = "mockArtistName";
  track.name = "mockTrackName";
  track.artistViewUrl = "mockArtistViewUrl";
  track.trackPreviewUrl = "mockPreviewUrl";
  track.coverUrl = "mockArtworkUrl100";
  track.price = 1.5;
  return TrackList(trackCount: 1, tracks: [track]);
}

Future<http.Response> _getServiceGoodAnswerFuture() async {
  return http.Response(
      '{ "resultCount": 1, "results": [{"artistName": "mockArtistName", '
      '"trackName": "mockTrackName", "artistViewUrl": "mockArtistViewUrl", '
      '"previewUrl": "mockPreviewUrl", "artworkUrl100": "mockArtworkUrl100",'
      ' "trackPrice": 1.5}]}',
      200);
}

Future<http.Response> _getServiceUnavailableFuture() async {
  return http.Response("no matter", 400);
}

Future<ConnectivityResult> _getConnectivityFuture() async {
  return ConnectivityResult.wifi;
}

Future<ConnectivityResult> _getNoConnectivityFuture() async {
  return ConnectivityResult.none;
}

class MockConnectivity extends Mock implements Connectivity {}

class MockService extends Mock implements SearchTracksService {}
