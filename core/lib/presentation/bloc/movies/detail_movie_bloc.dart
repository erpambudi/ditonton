import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail getMovie;

  DetailMovieBloc({
    required this.getMovie,
  }) : super(DetailMovieEmpty());

  @override
  Stream<DetailMovieState> mapEventToState(
    DetailMovieEvent event,
  ) async* {
    if (event is GetDetailMovieEvent) {
      yield DetailMovieLoading();
      final result = await getMovie.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield DetailMovieError(failure.message);
        },
        (data) async* {
          yield DetailMovieHasData(data);
        },
      );
    }
  }
}
