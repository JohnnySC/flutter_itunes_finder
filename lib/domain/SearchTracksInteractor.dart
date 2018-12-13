import 'package:itunes_finder/data/TrackList.dart';

abstract class SearchTracksInteractor {

  void searchTracks(String text);

  void setDataCallback(SearchTracksInteractorDataCallback callback);
}

abstract class SearchTracksInteractorDataCallback {

  void returnError();

  void returnTracks(List<Track> tracks);
}