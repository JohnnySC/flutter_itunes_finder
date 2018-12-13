import 'package:itunes_finder/data/TrackList.dart';

abstract class SearchTracksView {

  void showError(String text);

  void showProgress();

  void showTracks(List<Track> tracks);

  void clear();
}