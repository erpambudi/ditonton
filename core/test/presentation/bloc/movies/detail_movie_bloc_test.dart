import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/presentation/bloc/movies/detail_movie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetDetailMovie;

  setUp(() {
    mockGetDetailMovie = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(getMovie: mockGetDetailMovie);
  });

  test('initial state should be empty', () {
    expect(detailMovieBloc.state, DetailMovieEmpty());
  });

  final tId = 1;

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetDetailMovie.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(GetDetailMovieEvent(id: tId)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetDetailMovie.execute(tId));
    },
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetDetailMovie.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(GetDetailMovieEvent(id: tId)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetDetailMovie.execute(tId));
    },
  );
}
