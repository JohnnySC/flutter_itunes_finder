import 'package:itunes_finder/data/SearchTracksService.dart';
import 'package:http/http.dart' as http;

class SearchTracksServiceImpl implements SearchTracksService {
  static const url = 'https://itunes.apple.com/search?term=';

  @override
  Future<http.Response> searchTracks(String keyword) {
    return http.get(url + keyword);
  }
}