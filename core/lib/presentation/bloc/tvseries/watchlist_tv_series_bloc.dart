import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTvSeries _getTvSeries;

  WatchlistTvSeriesBloc(this._getTvSeries) : super(WatchlistTvSeriesEmpty());

  @override
  Stream<WatchlistTvSeriesState> mapEventToState(
    WatchlistTvSeriesEvent event,
  ) async* {
    if (event is GetWatchlistTvSeriesEvent) {
      yield WatchlistTvSeriesLoading();
      final result = await _getTvSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield WatchlistTvSeriesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield WatchlistTvSeriesNoData('Watchlist is still empty');
          } else {
            yield WatchlistTvSeriesHasData(data);
          }
        },
      );
    }
  }
}
