import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_movies_event.dart';
part 'top_movies_state.dart';

class TopMoviesBloc extends Bloc<TopMoviesEvent, TopMoviesState> {
  final GetTopRatedMovies _getMovies;

  TopMoviesBloc(this._getMovies) : super(TopMoviesEmpty());

  @override
  Stream<TopMoviesState> mapEventToState(
    TopMoviesEvent event,
  ) async* {
    if (event is GetTopMoviesEvent) {
      yield TopMoviesLoading();
      final result = await _getMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield TopMoviesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield TopMoviesNoData('Empty Data');
          } else {
            yield TopMoviesHasData(data);
          }
        },
      );
    }
  }
}
