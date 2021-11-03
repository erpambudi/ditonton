import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries _getTvSeries;

  NowPlayingTvSeriesBloc(this._getTvSeries) : super(NowPlayingTvSeriesEmpty());

  @override
  Stream<NowPlayingTvSeriesState> mapEventToState(
    NowPlayingTvSeriesEvent event,
  ) async* {
    if (event is GetNowPlayingTvSeriesEvent) {
      yield NowPlayingTvSeriesLoading();
      final result = await _getTvSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield NowPlayingTvSeriesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield NowPlayingTvSeriesNoData('Empty Data');
          } else {
            yield NowPlayingTvSeriesHasData(data);
          }
        },
      );
    }
  }
}
