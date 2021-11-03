import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getMovies;

  PopularMoviesBloc(this._getMovies) : super(MoviesEmpty());

  @override
  Stream<PopularMoviesState> mapEventToState(
    PopularMoviesEvent event,
  ) async* {
    if (event is GetPopularMoviesEvent) {
      yield MoviesLoading();
      final result = await _getMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield MoviesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield MoviesNoData('Empty Data');
          } else {
            yield MoviesHasData(data);
          }
        },
      );
    }
  }
}
