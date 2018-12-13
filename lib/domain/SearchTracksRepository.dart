import 'package:http/http.dart' as http;

abstract class SearchTracksRepository {
  Future<http.Response> fetchTracksList(String keyword);
}
