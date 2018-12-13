import 'package:itunes_finder/data/TrackList.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/domain/SearchTracksRepository.dart';
import 'dart:convert';

class SearchTracksInteractorImpl implements SearchTracksInteractor {
  final SearchTracksRepository mRepository;
  SearchTracksInteractorDataCallback mDataCallback;

  SearchTracksInteractorImpl(this.mRepository);

  @override
  void searchTracks(String text) {
    //todo handle internet connection
    _searchTracksInternal(text);
  }

  @override
  void setDataCallback(SearchTracksInteractorDataCallback callback) {
    mDataCallback = callback;
  }

  void _searchTracksInternal(String text) async {
    final response = await mRepository.fetchTracksList(text);

    if (mDataCallback != null) {
      if (response.statusCode == 200) {
        mDataCallback.returnTracks(
            TrackList.fromJson(json.decode(response.body)).tracks);
      } else {
        mDataCallback.returnError();
      }
    }
  }

}
