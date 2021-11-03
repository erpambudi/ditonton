import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/presentation/bloc/tvseries/top_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopTvSeriesBloc topTvSeriesBloc;
  late MockGetTopRatedTvSeries mockGetTopTvSeries;

  setUp(() {
    mockGetTopTvSeries = MockGetTopRatedTvSeries();
    topTvSeriesBloc = TopTvSeriesBloc(mockGetTopTvSeries);
  });

  test('initial state should be empty', () {
    expect(topTvSeriesBloc.state, TopTvSeriesEmpty());
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

  blocTest<TopTvSeriesBloc, TopTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return topTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopTvSeriesEvent()),
    expect: () => [
      TopTvSeriesLoading(),
      TopTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopTvSeries.execute());
    },
  );

  blocTest<TopTvSeriesBloc, TopTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTopTvSeriesEvent()),
    expect: () => [
      TopTvSeriesLoading(),
      TopTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopTvSeries.execute());
    },
  );
}
