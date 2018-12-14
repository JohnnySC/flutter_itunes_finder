import 'package:itunes_finder/presentation/SearchTracksView.dart';

abstract class SearchTracksPresenter {

  void getTracks(String text);

  void setView(SearchTracksView view);
}