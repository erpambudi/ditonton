import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/save_watchlist_tv_series.dart';
import 'package:core/presentation/cubit/status_watchlist_tv_serie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'status_watchlist_tv_series_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusTvSeries,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late StatusWatchlistTvSerieCubit statusWatchlistTvSerieCubit;
  late MockGetWatchListStatusTvSeries mockGetWatchlistStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlist;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListStatusTvSeries();
    mockSaveWatchlist = MockSaveWatchlistTvSeries();
    mockRemoveWatchlist = MockRemoveWatchlistTvSeries();
    statusWatchlistTvSerieCubit = StatusWatchlistTvSerieCubit(
      getWatchListStatus: mockGetWatchlistStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  blocTest<StatusWatchlistTvSerieCubit, StatusWatchlistTvSerieState>(
    'should get the watchlist status',
    build: () {
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      return statusWatchlistTvSerieCubit;
    },
    act: (bloc) => bloc.loadWatchlistStatus(1),
    expect: () => [
      StatusWatchlistTvSerieLoading(),
      StatusWatchlistTvSerieLoaded(status: true),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistStatus.execute(1));
    },
  );

  blocTest<StatusWatchlistTvSerieCubit, StatusWatchlistTvSerieState>(
    'should execute save watchlist when function called',
    build: () {
      when(mockSaveWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);
      return statusWatchlistTvSerieCubit;
    },
    act: (bloc) => bloc.addWatchlist(testTvSeriesDetail),
    expect: () => [
      StatusWatchlistTvSerieLoading(),
      StatusWatchlistTvSerieLoaded(status: true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testTvSeriesDetail));
    },
  );

  blocTest<StatusWatchlistTvSerieCubit, StatusWatchlistTvSerieState>(
    'should execute remove watchlist when function called',
    build: () {
      when(mockRemoveWatchlist.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);
      return statusWatchlistTvSerieCubit;
    },
    act: (bloc) => bloc.removeFromWatchlist(testTvSeriesDetail),
    expect: () => [
      StatusWatchlistTvSerieLoading(),
      StatusWatchlistTvSerieLoaded(status: false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testTvSeriesDetail));
    },
  );
}
