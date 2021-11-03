import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getMovies;

  NowPlayingMoviesBloc(this._getMovies) : super(NowPlayingMoviesEmpty());

  @override
  Stream<NowPlayingMoviesState> mapEventToState(
    NowPlayingMoviesEvent event,
  ) async* {
    if (event is GetNowPlayingMoviesEvent) {
      yield NowPlayingMoviesLoading();
      final result = await _getMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield NowPlayingMoviesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield NowPlayingMoviesNoData('Empty Data');
          } else {
            yield NowPlayingMoviesHasData(data);
          }
        },
      );
    }
  }
}
