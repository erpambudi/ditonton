import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_watchlist_movie_state.dart';

class StatusWatchlistMovieCubit extends Cubit<StatusWatchlistMovieState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  StatusWatchlistMovieCubit({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(StatusWatchlistMovieInitial());

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(MovieDetail movie) async {
    emit(StatusWatchlistMovieLoading());
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
        emit(StatusWatchlistMovieError());
      },
      (successMessage) async {
        _watchlistMessage = successMessage;

        await loadWatchlistStatus(movie.id);
        emit(StatusWatchlistMovieLoaded(status: true));
      },
    );
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    emit(StatusWatchlistMovieLoading());
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
        emit(StatusWatchlistMovieError());
      },
      (successMessage) async {
        _watchlistMessage = successMessage;

        await loadWatchlistStatus(movie.id);
        emit(StatusWatchlistMovieLoaded(status: false));
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    emit(StatusWatchlistMovieLoading());
    final result = await getWatchListStatus.execute(id);
    emit(StatusWatchlistMovieLoaded(status: result));
  }
}
