import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSerieRpository;

  setUp(() {
    mockTvSerieRpository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSerieRpository);
  });

  final tTvSeries = <TvSeries>[];

  group('GetPopularTvSeries Tests', () {
    group('execute', () {
      test(
          'should get list of TvSeries from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvSerieRpository.getPopularTvSeries())
            .thenAnswer((_) async => Right(tTvSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvSeries));
      });
    });
  });
}
