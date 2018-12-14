import 'package:itunes_finder/data/TrackList.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenter.dart';
import 'package:itunes_finder/presentation/SearchTracksView.dart';

class SearchTracksPresenterImpl implements SearchTracksPresenter, SearchTracksInteractorDataCallback {
  static const SEARCH_CHARACTERS_MIN = 4;

  final SearchTracksInteractor mInteractor;
  SearchTracksView mView;

  SearchTracksPresenterImpl(this.mInteractor);

  @override
  void getTracks(String text) {
    if (text.length >= SEARCH_CHARACTERS_MIN) {
      if (mView != null) mView.showProgress();
      mInteractor.setDataCallback(this);
      mInteractor.searchTracks(text);
    } else {
      if (mView != null) mView.clear();
    }
  }

  @override
  void setView(SearchTracksView view) {
    mView = view;
  }

  @override
  void returnError(String error) {
    if (mView != null) mView.showError(error);
  }

  @override
  void returnTracks(List<Track> tracks) {
    if (mView != null) mView.showTracks(tracks);
  }
}