import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenter.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenterImpl.dart';
import 'package:itunes_finder/presentation/SearchTracksView.dart';

import 'package:mockito/mockito.dart';

void main() {
  SearchTracksInteractor interactor = MockInteractor();
  SearchTracksPresenter presenter = SearchTracksPresenterImpl(interactor);
  SearchTracksView view = MockView();
  presenter.setView(view);

  test('testing presenter', () {
    final enoughLongTextToSearch = "quiteLong";
    presenter.getTracks(enoughLongTextToSearch);
    verify(view.showProgress());
    verify(interactor.searchTracks(enoughLongTextToSearch));

    final tooShortTextToSearch = "one";
    presenter.getTracks(tooShortTextToSearch);
    verify(view.clear());
  });
}

class MockInteractor extends Mock implements SearchTracksInteractor {}

class MockView extends Mock implements SearchTracksView {}
