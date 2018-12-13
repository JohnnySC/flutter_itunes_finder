import 'package:itunes_finder/data/TrackList.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/domain/SearchTracksRepository.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

class SearchTracksInteractorImpl implements SearchTracksInteractor {

  final SearchTracksRepository mRepository;
  SearchTracksInteractorDataCallback mDataCallback;

  SearchTracksInteractorImpl(this.mRepository);

  @override
  void searchTracks(String text) {
    _tryFetchTracksInternal(text);
  }

  @override
  void setDataCallback(SearchTracksInteractorDataCallback callback) {
    mDataCallback = callback;
  }

  void _tryFetchTracksInternal(String text) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      _searchTracksInternal(text);
    } else {
      if (mDataCallback != null) {
        mDataCallback.returnError("Please, check internet connectivity");
      }
    }
  }

  void _searchTracksInternal(String text) async {
    final response = await mRepository.fetchTracksList(text);

    if (mDataCallback != null) {
      if (response.statusCode == 200) {
        mDataCallback.returnTracks(
            TrackList.fromJson(json.decode(response.body)).tracks);
      } else {
        mDataCallback.returnError("Oops... Server error");
      }
    }
  }
}
