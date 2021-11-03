import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/cubit/status_watchlist_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'status_watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late StatusWatchlistMovieCubit statusWatchlistMovieCubit;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    statusWatchlistMovieCubit = StatusWatchlistMovieCubit(
      getWatchListStatus: mockGetWatchlistStatus,
      removeWatchlist: mockRemoveWatchlist,
      saveWatchlist: mockSaveWatchlist,
    );
  });

  blocTest<StatusWatchlistMovieCubit, StatusWatchlistMovieState>(
    'should get the watchlist status',
    build: () {
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      return statusWatchlistMovieCubit;
    },
    act: (bloc) => bloc.loadWatchlistStatus(1),
    expect: () => [
      StatusWatchlistMovieLoading(),
      StatusWatchlistMovieLoaded(status: true),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistStatus.execute(1));
    },
  );

  blocTest<StatusWatchlistMovieCubit, StatusWatchlistMovieState>(
    'should execute save watchlist when function called',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      return statusWatchlistMovieCubit;
    },
    act: (bloc) => bloc.addWatchlist(testMovieDetail),
    expect: () => [
      StatusWatchlistMovieLoading(),
      StatusWatchlistMovieLoaded(status: true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<StatusWatchlistMovieCubit, StatusWatchlistMovieState>(
    'should execute remove watchlist when function called',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      return statusWatchlistMovieCubit;
    },
    act: (bloc) => bloc.removeFromWatchlist(testMovieDetail),
    expect: () => [
      StatusWatchlistMovieLoading(),
      StatusWatchlistMovieLoaded(status: false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
