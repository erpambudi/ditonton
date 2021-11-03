import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'status_watchlist_tv_serie_state.dart';

class StatusWatchlistTvSerieCubit extends Cubit<StatusWatchlistTvSerieState> {
  final GetWatchListStatusTvSeries getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  StatusWatchlistTvSerieCubit({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(StatusWatchlistTvSerieInitial());

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvSeriesDetail tvSerie) async {
    emit(StatusWatchlistTvSerieLoading());
    final result = await saveWatchlist.execute(tvSerie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
        emit(StatusWatchlistTvSerieError());
      },
      (successMessage) async {
        _watchlistMessage = successMessage;

        await loadWatchlistStatus(tvSerie.id);
        emit(StatusWatchlistTvSerieLoaded(status: true));
      },
    );
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tvSerie) async {
    emit(StatusWatchlistTvSerieLoading());
    final result = await removeWatchlist.execute(tvSerie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
        emit(StatusWatchlistTvSerieError());
      },
      (successMessage) async {
        _watchlistMessage = successMessage;

        await loadWatchlistStatus(tvSerie.id);
        emit(StatusWatchlistTvSerieLoaded(status: false));
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    emit(StatusWatchlistTvSerieLoading());
    final result = await getWatchListStatus.execute(id);
    emit(StatusWatchlistTvSerieLoaded(status: result));
  }
}
