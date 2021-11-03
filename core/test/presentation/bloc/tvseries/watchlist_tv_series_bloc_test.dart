import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:core/presentation/bloc/tvseries/watchlist_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesBloc = WatchlistTvSeriesBloc(mockGetWatchlistTvSeries);
  });

  test('initial state should be empty', () {
    expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesEmpty());
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

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvSeriesEvent()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvSeriesEvent()),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
}
