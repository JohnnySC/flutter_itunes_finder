import 'package:http/http.dart' as http;

abstract class SearchTracksService {
  Future<http.Response> searchTracks(String keyWord);
}