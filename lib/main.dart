import 'package:flutter/material.dart';
import 'package:itunes_finder/ApiClient.dart';
import 'package:itunes_finder/TrackList.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Itunes Finder',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Itunes Finder'),
            ),
            body: new SearchTracksWidget()));
  }
}

class SearchTracksWidget extends StatefulWidget {
  @override
  SearchTracksWidgetState createState() => SearchTracksWidgetState();
}

class SearchTracksWidgetState extends State<SearchTracksWidget> {
  final mTextEditController = TextEditingController();
  String _text = "";

  @override
  void dispose() {
    mTextEditController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    mTextEditController.addListener(_searchTracks);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[
          TextField(
            controller: mTextEditController,
          ),
          _buildTrackList(_text),
        ],
      ),
    );
  }

  _searchTracks() {
    setState(() {
      _text = mTextEditController.text;
    });
  }

  Widget _buildTrackList(String text) {
    return FutureBuilder<TrackList>(
      future: fetchTrackList(text),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.tracks != null && snapshot.data.tracks.length > 0) {
            return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data.trackCount,
                    itemBuilder: (context, i) {
                      return _buildTrackRow(snapshot.data.tracks[i]);
                    }));
          } else {
            return Spacer();
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildTrackRow(Track track) {
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

  AudioPlayer audioPlayer;

  _playAudio(String url) {
    if (audioPlayer != null) {
      audioPlayer.release();
    }
    audioPlayer = new AudioPlayer();
    AudioPlayer.logEnabled = true;
    play(url);
  }

  play(String url) async {
    int result = await audioPlayer.play(url);
    if (result == 1) {
      // success
    }
  }
}
