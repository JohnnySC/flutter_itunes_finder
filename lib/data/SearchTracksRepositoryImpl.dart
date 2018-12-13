import 'package:http/http.dart' as http;
import 'package:itunes_finder/domain/SearchTracksRepository.dart';

class SearchTracksRepositoryImpl implements SearchTracksRepository {
  static const url = 'https://itunes.apple.com/search?term=';

  @override
  Future<http.Response> fetchTracksList(String keyword) {
    return http.get(url + keyword);
  }
}
