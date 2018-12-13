import 'package:flutter/material.dart';
import 'package:itunes_finder/data/TrackList.dart';
import 'package:audioplayers/audioplayers.dart';

Widget buildTrackRow(Track track) {
  return InkWell(
      onTap: () {
        _playAudio(track.trackPreviewUrl);
      },
      child: Container(
          padding: EdgeInsets.all(16.0),
          child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(track.coverUrl),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                track.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                track.artistName,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    '\$' + track.price.toString(),
                                    style: TextStyle(color: Colors.blueGrey),
                                  ))
                            ])))
              ])));
}

AudioPlayer _audioPlayer;

_playAudio(String url) {
  if (_audioPlayer != null) {
    _audioPlayer.release();
  }
  _audioPlayer = new AudioPlayer();
  AudioPlayer.logEnabled = true;
  play(url);
}

play(String url) async {
  int result = await _audioPlayer.play(url);
  if (result == 1) {
    // success
  }
}