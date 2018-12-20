import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:itunes_finder/data/Exceptions.dart';
import 'package:itunes_finder/data/SearchTracksService.dart';
import 'package:itunes_finder/data/TrackList.dart';
import 'package:itunes_finder/domain/SearchTracksRepository.dart';

class SearchTracksRepositoryImpl implements SearchTracksRepository {
  final Connectivity mConnectivity;
  final SearchTracksService mService;

  SearchTracksRepositoryImpl(this.mConnectivity, this.mService);

  @override
  Future<TrackList> fetchTracksList(String keyword) async {
    var connectivityResult = await (mConnectivity.checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      throw NoConnectionException();
    } else {
      http.Response response = await mService.searchTracks(keyword);

      if (response.statusCode == 200) {
        return TrackList.fromJson(json.decode(response.body));
      } else {
        throw ServiceUnavailableException();
      }
    }
  }
}