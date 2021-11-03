import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/presentation/bloc/tvseries/recommendation_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late RecommendationTvSeriesBloc recommendationTvSeriesBloc;
  late MockGetTvSeriesRecommendations mockGetRecommendationTvSeries;

  setUp(() {
    mockGetRecommendationTvSeries = MockGetTvSeriesRecommendations();
    recommendationTvSeriesBloc =
        RecommendationTvSeriesBloc(mockGetRecommendationTvSeries);
  });

  test('initial state should be empty', () {
    expect(recommendationTvSeriesBloc.state, RecommendationTvSeriesEmpty());
  });

  final tTvSerie = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesList = <TvSeries>[tTvSerie];
  final tId = 1;

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return recommendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationTvSeriesEvent(tId)),
    expect: () => [
      RecommendationTvSeriesLoading(),
      RecommendationTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvSeries.execute(tId));
    },
  );

  blocTest<RecommendationTvSeriesBloc, RecommendationTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetRecommendationTvSeries.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendationTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetRecommendationTvSeriesEvent(tId)),
    expect: () => [
      RecommendationTvSeriesLoading(),
      RecommendationTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTvSeries.execute(tId));
    },
  );
}
