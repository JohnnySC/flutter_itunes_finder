import 'package:connectivity/connectivity.dart';
import 'package:itunes_finder/data/SearchTracksRepositoryImpl.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/domain/SearchTracksInteractorImpl.dart';
import 'package:itunes_finder/domain/SearchTracksRepository.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenter.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenterImpl.dart';

class DependencyInjector {
  SearchTracksRepository _repository;
  SearchTracksInteractor _interactor;
  SearchTracksPresenter _presenter;

  static final DependencyInjector _singleton =
      new DependencyInjector._internal();

  factory DependencyInjector() {
    return _singleton;
  }

  DependencyInjector._internal() {
    _repository = SearchTracksRepositoryImpl(Connectivity());
    _interactor = SearchTracksInteractorImpl(_repository);
    _presenter = SearchTracksPresenterImpl(_interactor);
  }

  SearchTracksPresenter get presenter => _presenter;
}