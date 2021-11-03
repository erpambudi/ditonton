import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries _getTvSeries;

  PopularTvSeriesBloc(this._getTvSeries) : super(PopularTvSeriesEmpty());

  @override
  Stream<PopularTvSeriesState> mapEventToState(
    PopularTvSeriesEvent event,
  ) async* {
    if (event is GetPopularTvSeriesEvent) {
      yield PopularTvSeriesLoading();
      final result = await _getTvSeries.execute();

      yield* result.fold(
        (failure) async* {
          yield PopularTvSeriesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield PopularTvSeriesNoData('Empty Data');
          } else {
            yield PopularTvSeriesHasData(data);
          }
        },
      );
    }
  }
}
