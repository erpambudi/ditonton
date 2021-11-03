import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_tv_series_event.dart';
part 'top_tv_series_state.dart';

class TopTvSeriesBloc extends Bloc<TopTvSeriesEvent, TopTvSeriesState> {
  final GetTopRatedTvSeries _getTvSeries;

  TopTvSeriesBloc(this._getTvSeries) : super(TopTvSeriesEmpty());

  @override
  Stream<TopTvSeriesState> mapEventToState(
    TopTvSeriesEvent event,
  ) async* {
    if (event is GetTopTvSeriesEvent) {
      yield TopTvSeriesLoading();
      final result = await _getTvSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield TopTvSeriesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield TopTvSeriesNoData('Empty Data');
          } else {
            yield TopTvSeriesHasData(data);
          }
        },
      );
    }
  }
}
