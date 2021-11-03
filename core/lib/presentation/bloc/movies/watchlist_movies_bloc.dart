import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getMovies;

  WatchlistMoviesBloc(this.getMovies) : super(WatchlistMoviesEmpty());

  @override
  Stream<WatchlistMoviesState> mapEventToState(
    WatchlistMoviesEvent event,
  ) async* {
    if (event is GetWatchlistMoviesEvent) {
      yield WatchlistMoviesLoading();
      final result = await getMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield WatchlistMoviesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield WatchlistMoviesNoData('Watchlist is still empty');
          } else {
            yield WatchlistMoviesHasData(data);
          }
        },
      );
    }
  }
}
