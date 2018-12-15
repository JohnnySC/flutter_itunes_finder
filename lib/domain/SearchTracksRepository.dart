import 'package:itunes_finder/data/TrackList.dart';

abstract class SearchTracksRepository {
  Future<TrackList> fetchTracksList(String keyword);
}
