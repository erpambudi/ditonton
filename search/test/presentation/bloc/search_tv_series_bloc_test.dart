import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/search_tv_series_bloc.dart';

import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesBloc searchBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchBloc = SearchTvSeriesBloc(mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchTvSeriesEmpty());
  });

  final tTvSerie = TvSeries(
    adult: false,
    backdropPath: '/1i1N0AVRb54H6ZFPDTwbo9MLxSF.jpg',
    genreIds: [10765, 9648, 18],
    id: 85271,
    originalName: 'WandaVision',
    overview:
        'Wanda Maximoff and Vision—two super-powered beings living idealized suburban lives—begin to suspect that everything is not as it seems.',
    popularity: 271.279,
    posterPath: '/glKDfE6btIRcVB5zrjspRIs4r52.jpg',
    name: 'WandaVision',
    voteAverage: 8.4,
    voteCount: 9275,
  );
  final tTvSeriesList = <TvSeries>[tTvSerie];
  final tQuery = 'spiderman';

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvSeriesChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest<SearchTvSeriesBloc, SearchTvSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvSeriesChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );
}
