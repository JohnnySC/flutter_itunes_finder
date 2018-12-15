import 'package:itunes_finder/data/TrackList.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/domain/SearchTracksRepository.dart';
import 'package:rxdart/rxdart.dart';

class SearchTracksInteractorImpl implements SearchTracksInteractor {
  final SearchTracksRepository mRepository;
  SearchTracksInteractorDataCallback mDataCallback;

  SearchTracksInteractorImpl(this.mRepository);

  @override
  void searchTracks(String text) {
    Observable.fromFuture(mRepository.fetchTracksList(text))
        .doOnData(_onSuccess)
        .handleError(_handleError)
        .listen(null);
  }

  @override
  void setDataCallback(SearchTracksInteractorDataCallback callback) {
    mDataCallback = callback;
  }

  void _onSuccess(TrackList data) {
    if (mDataCallback != null) {
      mDataCallback.returnTracks(data.tracks);
    }
  }

  void _handleError(dynamic e) {
    if (mDataCallback != null) {
      mDataCallback.returnError(e.toString());
    }
  }
}
