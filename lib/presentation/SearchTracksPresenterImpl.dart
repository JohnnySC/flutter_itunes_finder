import 'package:itunes_finder/data/TrackList.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenter.dart';
import 'package:itunes_finder/presentation/SearchTracksView.dart';

class SearchTracksPresenterImpl implements SearchTracksPresenter, SearchTracksInteractorDataCallback {

  static const SEARCH_CHARACTERS_MIN = 4;

  final SearchTracksView mView;
  final SearchTracksInteractor mInteractor;

  SearchTracksPresenterImpl(this.mView, this.mInteractor);

  @override
  void getTracks(String text) {
    if (text.length >= SEARCH_CHARACTERS_MIN) {
      mView.showProgress();
      mInteractor.setDataCallback(this);
      mInteractor.searchTracks(text);
    } else {
      mView.clear();
    }
  }

  @override
  void returnError(String error) {
    mView.showError(error);
  }

  @override
  void returnTracks(List<Track> tracks) {
    mView.showTracks(tracks);
  }
}