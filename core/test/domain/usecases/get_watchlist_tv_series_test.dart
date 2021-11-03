import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSerieRepository;

  setUp(() {
    mockTvSerieRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeries(mockTvSerieRepository);
  });

  test('should get list of TvSeries from the repository', () async {
    // arrange
    when(mockTvSerieRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvSeriesList));
  });
}
