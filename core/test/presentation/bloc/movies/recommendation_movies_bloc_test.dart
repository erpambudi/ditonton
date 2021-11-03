import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/presentation/bloc/movies/recommendation_movies_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMoviesBloc recommendationMoviesBloc;
  late MockGetMovieRecommendations mockGetRecommendationMovies;

  setUp(() {
    mockGetRecommendationMovies = MockGetMovieRecommendations();
    recommendationMoviesBloc =
        RecommendationMoviesBloc(mockGetRecommendationMovies);
  });

  test('initial state should be empty', () {
    expect(recommendationMoviesBloc.state, MoviesEmpty());
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
  final tId = 1;

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationMovies.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationMoviesEvent(id: tId)),
    expect: () => [
      MoviesLoading(),
      MoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovies.execute(tId));
    },
  );

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetRecommendationMovies.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationMoviesEvent(id: tId)),
    expect: () => [
      MoviesLoading(),
      MoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovies.execute(tId));
    },
  );
}
