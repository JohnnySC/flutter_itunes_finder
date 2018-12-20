import 'package:connectivity/connectivity.dart';
import 'package:itunes_finder/data/SearchTracksRepositoryImpl.dart';
import 'package:itunes_finder/data/SearchTracksService.dart';
import 'package:itunes_finder/data/SearchTracksServiceImpl.dart';
import 'package:itunes_finder/domain/SearchTracksInteractor.dart';
import 'package:itunes_finder/domain/SearchTracksInteractorImpl.dart';
import 'package:itunes_finder/domain/SearchTracksRepository.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenter.dart';
import 'package:itunes_finder/presentation/SearchTracksPresenterImpl.dart';

class DependencyInjector {
  Connectivity _connectivity;
  SearchTracksService _service;
  SearchTracksRepository _repository;
  SearchTracksInteractor _interactor;
  SearchTracksPresenter _presenter;

  static final DependencyInjector _singleton =
      new DependencyInjector._internal();

  factory DependencyInjector() {
    return _singleton;
  }

  DependencyInjector._internal() {
    _connectivity = Connectivity();
    _service = SearchTracksServiceImpl();
    _repository = SearchTracksRepositoryImpl(_connectivity, _service);
    _interactor = SearchTracksInteractorImpl(_repository);
    _presenter = SearchTracksPresenterImpl(_interactor);
  }

  SearchTracksPresenter get presenter => _presenter;
}