import 'package:flutter/material.dart';
import 'package:itunes_finder/data/SearchTracksRepositoryImpl.dart';
import 'package:itunes_finder/data/TrackList.dart';
import 'package:itunes_finder/domain/SearchTracksInteractorImpl.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenter.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenterImpl.dart';
import 'package:itunes_finder/presentation/SearchTracksView.dart';
import 'package:itunes_finder/presentation/TrackWidget.dart';

class SearchTracksWidget extends StatefulWidget {
  @override
  SearchTracksWidgetState createState() => SearchTracksWidgetState();
}

class SearchTracksWidgetState extends State<SearchTracksWidget>
    implements SearchTracksView {
  static const int STATE_PROGRESS = 0;
  static const int STATE_ERROR = 1;
  static const int STATE_SUCCESS = 2;
  final mTextEditController = TextEditingController();

  String _error;
  int _state;
  SearchTracksPresenter _presenter;
  List<Track> _tracks;

  @override
  void dispose() {
    mTextEditController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //todo find a better way to inject dependencies
    _presenter = SearchTracksPresenterImpl(
        this, SearchTracksInteractorImpl(SearchTracksRepositoryImpl()));
    mTextEditController.addListener(_searchTracks);
  }

  void _searchTracks() {
    _presenter.getTracks(mTextEditController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: mTextEditController,
            decoration: InputDecoration(
                hintText:
                    'At least ${SearchTracksPresenterImpl.SEARCH_CHARACTERS_MIN} characters to search track'),
          ),
          _buildTrackList(),
        ],
      ),
    );
  }

  @override
  void showError(String error) {
    setState(() {
      _state = STATE_ERROR;
      _error = error;
    });
  }

  @override
  void showProgress() {
    setState(() {
      _state = STATE_PROGRESS;
    });
  }

  @override
  void showTracks(List<Track> tracks) {
    setState(() {
      _state = STATE_SUCCESS;
      _tracks = tracks;
    });
  }

  @override
  void clear() {
    setState(() {
      _state = -1;
      _tracks = [];
    });
  }

  Widget _buildTrackList() {
    switch (_state) {
      case STATE_ERROR:
        return Text(_error);
      case STATE_SUCCESS:
        return Expanded(
            child: ListView.builder(
                itemCount: _tracks.length,
                itemBuilder: (context, i) {
                  return buildTrackRow(_tracks[i]);
                }));
      case STATE_PROGRESS:
        return CircularProgressIndicator();
      default:
        return Spacer();
    }
  }
}
