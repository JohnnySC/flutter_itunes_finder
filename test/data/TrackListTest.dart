import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_finder/data/TrackList.dart';

void main() {
  test('testing track parse', () {
    String source = '{"artistName": "mockArtistName", '
        '"trackName": "mockTrackName", "artistViewUrl": "mockArtistViewUrl", '
        '"previewUrl": "mockPreviewUrl", "artworkUrl100": "mockArtworkUrl100",'
        ' "trackPrice": 1.5}';
    Track actual = Track.fromJson(json.decode(source));
    Track expected = _getExpectedTrack();
    expect(actual.toString(), equals(expected.toString()));
  });

  test('testing tracklist parse', () {
    String source =
        '{ "resultCount": 1, "results": [{"artistName": "mockArtistName", '
        '"trackName": "mockTrackName", "artistViewUrl": "mockArtistViewUrl", '
        '"previewUrl": "mockPreviewUrl", "artworkUrl100": "mockArtworkUrl100",'
        ' "trackPrice": 1.5}]}';
    TrackList actual = TrackList.fromJson(json.decode(source));
    TrackList expected = _getExpectedTrackList();
    expect(actual.toString(), equals(expected.toString()));
  });
}

TrackList _getExpectedTrackList() {
  return TrackList(trackCount: 1, tracks: [_getExpectedTrack()]);
}

Track _getExpectedTrack() {
  Track track = Track();
  track.artistName = "mockArtistName";
  track.name = "mockTrackName";
  track.artistViewUrl = "mockArtistViewUrl";
  track.trackPreviewUrl = "mockPreviewUrl";
  track.coverUrl = "mockArtworkUrl100";
  track.price = 1.5;
  return track;
}