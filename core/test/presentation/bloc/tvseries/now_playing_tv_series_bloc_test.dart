import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:core/presentation/bloc/tvseries/now_playing_tv_series_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesBloc = NowPlayingTvSeriesBloc(mockGetNowPlayingTvSeries);
  });

  test('initial state should be empty', () {
    expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesEmpty());
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

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingTvSeriesEvent()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );

  blocTest<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingTvSeriesEvent()),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );
}
