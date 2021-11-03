import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/presentation/bloc/tvseries/detail_tv_serie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_tv_serie_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late DetailTvSerieBloc detailTvSerieBloc;
  late MockGetTvSeriesDetail mockGetDetailTvSerie;

  setUp(() {
    mockGetDetailTvSerie = MockGetTvSeriesDetail();
    detailTvSerieBloc = DetailTvSerieBloc(mockGetDetailTvSerie);
  });

  test('initial state should be empty', () {
    expect(detailTvSerieBloc.state, DetailTvSerieEmpty());
  });

  final tId = 1;

  blocTest<DetailTvSerieBloc, DetailTvSerieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetDetailTvSerie.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      return detailTvSerieBloc;
    },
    act: (bloc) => bloc.add(GetDetailTvSerieEvent(tId)),
    expect: () => [
      DetailTvSerieLoading(),
      DetailTvSerieHasData(testTvSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetDetailTvSerie.execute(tId));
    },
  );

  blocTest<DetailTvSerieBloc, DetailTvSerieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetDetailTvSerie.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailTvSerieBloc;
    },
    act: (bloc) => bloc.add(GetDetailTvSerieEvent(tId)),
    expect: () => [
      DetailTvSerieLoading(),
      DetailTvSerieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetDetailTvSerie.execute(tId));
    },
  );
}
