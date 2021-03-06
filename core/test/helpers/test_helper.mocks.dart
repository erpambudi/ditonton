// Mocks generated by Mockito 5.0.15 from annotations
// in core/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i9;
import 'dart:convert' as _i28;
import 'dart:io' as _i6;
import 'dart:typed_data' as _i29;

import 'package:core/data/datasources/db/database_helper.dart' as _i17;
import 'package:core/data/datasources/movie_local_data_source.dart' as _i15;
import 'package:core/data/datasources/movie_remote_data_source.dart' as _i13;
import 'package:core/data/datasources/tv_series_local_data_source.dart' as _i26;
import 'package:core/data/datasources/tv_series_remote_data_source.dart'
    as _i24;
import 'package:core/data/models/movie_detail_model.dart' as _i3;
import 'package:core/data/models/movie_model.dart' as _i14;
import 'package:core/data/models/movie_table.dart' as _i16;
import 'package:core/data/models/tv_series_detail_model.dart' as _i4;
import 'package:core/data/models/tv_series_model.dart' as _i25;
import 'package:core/data/models/tv_series_table.dart' as _i19;
import 'package:core/domain/entities/movie.dart' as _i11;
import 'package:core/domain/entities/movie_detail.dart' as _i12;
import 'package:core/domain/entities/tv_series.dart' as _i22;
import 'package:core/domain/entities/tv_series_detail.dart' as _i23;
import 'package:core/domain/repositories/movie_repository.dart' as _i8;
import 'package:core/domain/repositories/tv_series_repository.dart' as _i21;
import 'package:core/utils/failure.dart' as _i10;
import 'package:core/utils/network_info.dart' as _i20;
import 'package:core/utils/ssl_info.dart' as _i27;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i7;
import 'package:http/io_client.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i18;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeMovieDetailResponse_1 extends _i1.Fake
    implements _i3.MovieDetailResponse {}

class _FakeTvSeriesDetailModel_2 extends _i1.Fake
    implements _i4.TvSeriesDetailModel {}

class _FakeIOClient_3 extends _i1.Fake implements _i5.IOClient {}

class _FakeSecurityContext_4 extends _i1.Fake implements _i6.SecurityContext {}

class _FakeResponse_5 extends _i1.Fake implements _i7.Response {}

class _FakeStreamedResponse_6 extends _i1.Fake implements _i7.StreamedResponse {
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i8.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>
      getNowPlayingMovies() => (super.noSuchMethod(
          Invocation.method(#getNowPlayingMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(Invocation.method(#getPopularMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, _i12.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
          returnValue: Future<_i2.Either<_i10.Failure, _i12.MovieDetail>>.value(
              _FakeEither_0<_i10.Failure, _i12.MovieDetail>())) as _i9
          .Future<_i2.Either<_i10.Failure, _i12.MovieDetail>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>
      getMovieRecommendations(int? id) => (super.noSuchMethod(
          Invocation.method(#getMovieRecommendations, [id]),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> saveWatchlist(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> removeWatchlist(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i11.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>.value(
              _FakeEither_0<_i10.Failure, List<_i11.Movie>>())) as _i9
          .Future<_i2.Either<_i10.Failure, List<_i11.Movie>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i13.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i14.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingMovies, []),
              returnValue:
                  Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i9.Future<List<_i14.MovieModel>>);
  @override
  _i9.Future<List<_i14.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
      as _i9.Future<List<_i14.MovieModel>>);
  @override
  _i9.Future<List<_i14.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
          Invocation.method(#getTopRatedMovies, []),
          returnValue: Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
      as _i9.Future<List<_i14.MovieModel>>);
  @override
  _i9.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieDetail, [id]),
              returnValue: Future<_i3.MovieDetailResponse>.value(
                  _FakeMovieDetailResponse_1()))
          as _i9.Future<_i3.MovieDetailResponse>);
  @override
  _i9.Future<List<_i14.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieRecommendations, [id]),
              returnValue:
                  Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i9.Future<List<_i14.MovieModel>>);
  @override
  _i9.Future<List<_i14.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchMovies, [query]),
              returnValue:
                  Future<List<_i14.MovieModel>>.value(<_i14.MovieModel>[]))
          as _i9.Future<List<_i14.MovieModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i15.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<String> insertWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<String> removeWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i16.MovieTable?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<_i16.MovieTable?>.value())
          as _i9.Future<_i16.MovieTable?>);
  @override
  _i9.Future<List<_i16.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
          Invocation.method(#getWatchlistMovies, []),
          returnValue: Future<List<_i16.MovieTable>>.value(<_i16.MovieTable>[]))
      as _i9.Future<List<_i16.MovieTable>>);
  @override
  _i9.Future<void> cacheNowPlayingMovies(List<_i16.MovieTable>? movies) =>
      (super.noSuchMethod(Invocation.method(#cacheNowPlayingMovies, [movies]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<List<_i16.MovieTable>> getCachedNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#getCachedNowPlayingMovies, []),
              returnValue:
                  Future<List<_i16.MovieTable>>.value(<_i16.MovieTable>[]))
          as _i9.Future<List<_i16.MovieTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i17.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i18.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i18.Database?>.value())
          as _i9.Future<_i18.Database?>);
  @override
  _i9.Future<void> insertCacheTransaction(
          List<_i16.MovieTable>? movies, String? category) =>
      (super.noSuchMethod(
          Invocation.method(#insertCacheTransaction, [movies, category]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i9.Future<void>);
  @override
  _i9.Future<List<Map<String, dynamic>>> getCacheMovies(String? category) =>
      (super.noSuchMethod(Invocation.method(#getCacheMovies, [category]),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i9.Future<List<Map<String, dynamic>>>);
  @override
  _i9.Future<int> clearCache(String? category) =>
      (super.noSuchMethod(Invocation.method(#clearCache, [category]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<int> insertWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<int> removeWatchlist(_i16.MovieTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i9.Future<Map<String, dynamic>?>);
  @override
  _i9.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistMovies, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i9.Future<List<Map<String, dynamic>>>);
  @override
  _i9.Future<int> insertWatchlistTv(_i19.TvSeriesTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTv, [tv]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<int> removeWatchlistTv(_i19.TvSeriesTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTv, [tv]),
          returnValue: Future<int>.value(0)) as _i9.Future<int>);
  @override
  _i9.Future<Map<String, dynamic>?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i9.Future<Map<String, dynamic>?>);
  @override
  _i9.Future<List<Map<String, dynamic>>> getWatchlistTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvSeries, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i9.Future<List<Map<String, dynamic>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i20.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRepository extends _i1.Mock
    implements _i21.TvSeriesRepository {
  MockTvSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>
      getPopularTvSeries() => (super.noSuchMethod(
              Invocation.method(#getPopularTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i22.TvSeries>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>
      getTopRatedTvSeries() => (super.noSuchMethod(
              Invocation.method(#getTopRatedTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i22.TvSeries>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>
      getNowPlayingTvSeries() => (super.noSuchMethod(
              Invocation.method(#getNowPlayingTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i22.TvSeries>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, _i23.TvSeriesDetail>> getTvSeriesDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesDetail, [id]),
              returnValue:
                  Future<_i2.Either<_i10.Failure, _i23.TvSeriesDetail>>.value(
                      _FakeEither_0<_i10.Failure, _i23.TvSeriesDetail>()))
          as _i9.Future<_i2.Either<_i10.Failure, _i23.TvSeriesDetail>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>
      getTvSeriesRecommendations(int? id) => (super.noSuchMethod(
              Invocation.method(#getTvSeriesRecommendations, [id]),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i22.TvSeries>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i22.TvSeries>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> saveWatchlist(
          _i23.TvSeriesDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, String>> removeWatchlist(
          _i23.TvSeriesDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
              returnValue: Future<_i2.Either<_i10.Failure, String>>.value(
                  _FakeEither_0<_i10.Failure, String>()))
          as _i9.Future<_i2.Either<_i10.Failure, String>>);
  @override
  _i9.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i9.Future<bool>);
  @override
  _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>
      getWatchlistTvSeries() => (super.noSuchMethod(
              Invocation.method(#getWatchlistTvSeries, []),
              returnValue:
                  Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>.value(
                      _FakeEither_0<_i10.Failure, List<_i22.TvSeries>>()))
          as _i9.Future<_i2.Either<_i10.Failure, List<_i22.TvSeries>>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRemoteDataSource extends _i1.Mock
    implements _i24.TvSeriesRemoteDataSource {
  MockTvSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<List<_i25.TvSeriesModel>> getPopularTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvSeries, []),
          returnValue: Future<List<_i25.TvSeriesModel>>.value(
              <_i25.TvSeriesModel>[])) as _i9.Future<List<_i25.TvSeriesModel>>);
  @override
  _i9.Future<List<_i25.TvSeriesModel>> getTopRatedTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvSeries, []),
          returnValue: Future<List<_i25.TvSeriesModel>>.value(
              <_i25.TvSeriesModel>[])) as _i9.Future<List<_i25.TvSeriesModel>>);
  @override
  _i9.Future<List<_i25.TvSeriesModel>> getNowPlayingTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTvSeries, []),
          returnValue: Future<List<_i25.TvSeriesModel>>.value(
              <_i25.TvSeriesModel>[])) as _i9.Future<List<_i25.TvSeriesModel>>);
  @override
  _i9.Future<_i4.TvSeriesDetailModel> getTvSeriesDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesDetail, [id]),
              returnValue: Future<_i4.TvSeriesDetailModel>.value(
                  _FakeTvSeriesDetailModel_2()))
          as _i9.Future<_i4.TvSeriesDetailModel>);
  @override
  _i9.Future<List<_i25.TvSeriesModel>> getTvSeriesRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesRecommendations, [id]),
          returnValue: Future<List<_i25.TvSeriesModel>>.value(
              <_i25.TvSeriesModel>[])) as _i9.Future<List<_i25.TvSeriesModel>>);
  @override
  _i9.Future<List<_i25.TvSeriesModel>> searchTvSeries(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
          returnValue: Future<List<_i25.TvSeriesModel>>.value(
              <_i25.TvSeriesModel>[])) as _i9.Future<List<_i25.TvSeriesModel>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [TvSeriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesLocalDataSource extends _i1.Mock
    implements _i26.TvSeriesLocalDataSource {
  MockTvSeriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<String> insertWatchlist(_i19.TvSeriesTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tv]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<String> removeWatchlist(_i19.TvSeriesTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i19.TvSeriesTable?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesById, [id]),
              returnValue: Future<_i19.TvSeriesTable?>.value())
          as _i9.Future<_i19.TvSeriesTable?>);
  @override
  _i9.Future<List<_i19.TvSeriesTable>> getWatchlistTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvSeries, []),
          returnValue: Future<List<_i19.TvSeriesTable>>.value(
              <_i19.TvSeriesTable>[])) as _i9.Future<List<_i19.TvSeriesTable>>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [SslInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockSslInfo extends _i1.Mock implements _i27.SslInfo {
  MockSslInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i5.IOClient> get globalIoClient =>
      (super.noSuchMethod(Invocation.getter(#globalIoClient),
              returnValue: Future<_i5.IOClient>.value(_FakeIOClient_3()))
          as _i9.Future<_i5.IOClient>);
  @override
  _i9.Future<_i6.SecurityContext> get globalContext =>
      (super.noSuchMethod(Invocation.getter(#globalContext),
              returnValue:
                  Future<_i6.SecurityContext>.value(_FakeSecurityContext_4()))
          as _i9.Future<_i6.SecurityContext>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i7.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.Future<_i7.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_5()))
          as _i9.Future<_i7.Response>);
  @override
  _i9.Future<_i7.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_5()))
          as _i9.Future<_i7.Response>);
  @override
  _i9.Future<_i7.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i28.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_5()))
          as _i9.Future<_i7.Response>);
  @override
  _i9.Future<_i7.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i28.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_5()))
          as _i9.Future<_i7.Response>);
  @override
  _i9.Future<_i7.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i28.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_5()))
          as _i9.Future<_i7.Response>);
  @override
  _i9.Future<_i7.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i28.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_5()))
          as _i9.Future<_i7.Response>);
  @override
  _i9.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i9.Future<String>);
  @override
  _i9.Future<_i29.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i29.Uint8List>.value(_i29.Uint8List(0)))
          as _i9.Future<_i29.Uint8List>);
  @override
  _i9.Future<_i7.StreamedResponse> send(_i7.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i7.StreamedResponse>.value(_FakeStreamedResponse_6()))
          as _i9.Future<_i7.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}
