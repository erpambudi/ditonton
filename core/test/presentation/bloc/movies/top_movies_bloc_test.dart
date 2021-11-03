import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movies/top_movies_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopMoviesBloc topMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topMoviesBloc = TopMoviesBloc(mockGetTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(topMoviesBloc.state, TopMoviesEmpty());
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

  blocTest<TopMoviesBloc, TopMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return topMoviesBloc;
    },
    act: (bloc) => bloc.add(GetTopMoviesEvent()),
    expect: () => [
      TopMoviesLoading(),
      TopMoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopMoviesBloc, TopMoviesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topMoviesBloc;
    },
    act: (bloc) => bloc.add(GetTopMoviesEvent()),
    expect: () => [
      TopMoviesLoading(),
      TopMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
