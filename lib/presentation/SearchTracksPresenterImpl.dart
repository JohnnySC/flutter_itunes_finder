import 'package:itunes_finder/data/TrackList.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenter.dart';
import 'package:itunes_finder/presentation/SearchTracksView.dart';

class SearchTracksPresenterImpl implements SearchTracksPresenter, SearchTracksInteractorDataCallback {

  final SearchTracksView mView;
  final SearchTracksInteractor mInteractor;

  SearchTracksPresenterImpl(this.mView, this.mInteractor);

  @override
  void getTracks(String text) {
    if (text.length > 1) {
      mView.showProgress();
      mInteractor.setDataCallback(this);
      mInteractor.searchTracks(text);
    }
  }

  @override
  void returnError() {
    mView.showError("Check the connection");
  }

  @override
  void returnTracks(List<Track> tracks) {
    mView.showTracks(tracks);
  }

}