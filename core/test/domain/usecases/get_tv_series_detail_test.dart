import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSerieRepository;

  setUp(() {
    mockTvSerieRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSerieRepository);
  });

  final tId = 1;

  test('should get TvSerie detail from the repository', () async {
    // arrange
    when(mockTvSerieRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}
