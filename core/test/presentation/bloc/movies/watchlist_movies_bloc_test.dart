import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/presentation/bloc/movies/watchlist_movies_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesBloc = WatchlistMoviesBloc(mockGetWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(watchlistMoviesBloc.state, WatchlistMoviesEmpty());
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMoviesEvent()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistMoviesEvent()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
