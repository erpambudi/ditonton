import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/presentation/bloc/tvseries/popular_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  test('initial state should be empty', () {
    expect(popularTvSeriesBloc.state, PopularTvSeriesEmpty());
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

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetPopularTvSeriesEvent()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetPopularTvSeriesEvent()),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
