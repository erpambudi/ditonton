import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSerieRepository;

  setUp(() {
    mockTvSerieRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSerieRepository);
  });

  final tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of TvSerie recommendations from the repository',
      () async {
    // arrange
    when(mockTvSerieRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTvSeries));
  });
}
