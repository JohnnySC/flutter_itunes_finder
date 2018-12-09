import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itunes_finder/TrackList.dart';

Future<TrackList> fetchTrackList(String keyword) async {
  final response =
      await http.get('https://itunes.apple.com/search?term=' + keyword);

  if (response.statusCode == 200) {
    return TrackList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load tracklist');
  }
}