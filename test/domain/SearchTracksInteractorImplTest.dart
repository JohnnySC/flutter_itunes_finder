import 'package:itunes_finder/data/Exceptions.dart';
import 'package:itunes_finder/data/TrackList.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/domain/SearchTracksInteractorImpl.dart';
import 'package:itunes_finder/domain/SearchTracksRepository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SearchTracksRepository repository = MockRepository();
  SearchTracksInteractor interactor = SearchTracksInteractorImpl(repository);
  SearchTracksInteractorDataCallback callback = MockDataCallback();
  interactor.setDataCallback(callback);

  test('testing interactor success case', () async {
    when(repository.fetchTracksList(any)).thenAnswer((_) => _getMockedFuture());
    interactor.searchTracks("anytext");
    await untilCalled(callback.returnTracks(TrackList().tracks));
  });

  test('testing interactor fail cases', () async {
    when(repository.fetchTracksList(any))
        .thenAnswer((_) => _getConnectionExceptionFuture());
    interactor.searchTracks("nomatterwhat");
    await untilCalled(
        callback.returnError("Please, check internet connectivity"));

    when(repository.fetchTracksList(any))
        .thenAnswer((_) => _getServiceUnavailableExceptionFuture());
    interactor.searchTracks("nomatterwhat");
    await untilCalled(callback.returnError("Sorry, service is unavailable."));
  });
}

Future<TrackList> _getServiceUnavailableExceptionFuture() async {
  throw ServiceUnavailableException();
}

Future<TrackList> _getConnectionExceptionFuture() async {
  throw NoConnectionException();
}

Future<TrackList> _getMockedFuture() async {
  return TrackList();
}

class MockDataCallback extends Mock
    implements SearchTracksInteractorDataCallback {}

class MockRepository extends Mock implements SearchTracksRepository {}
