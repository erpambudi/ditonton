import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository mockTvSerieRepository;

  setUp(() {
    mockTvSerieRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockTvSerieRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of TvSeries from repository', () async {
    // arrange
    when(mockTvSerieRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}
