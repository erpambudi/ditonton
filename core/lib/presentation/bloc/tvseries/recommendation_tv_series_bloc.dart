import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recommendation_tv_series_event.dart';
part 'recommendation_tv_series_state.dart';

class RecommendationTvSeriesBloc
    extends Bloc<RecommendationTvSeriesEvent, RecommendationTvSeriesState> {
  final GetTvSeriesRecommendations _getTvSeries;

  RecommendationTvSeriesBloc(this._getTvSeries)
      : super(RecommendationTvSeriesEmpty());

  @override
  Stream<RecommendationTvSeriesState> mapEventToState(
    RecommendationTvSeriesEvent event,
  ) async* {
    if (event is GetRecommendationTvSeriesEvent) {
      yield RecommendationTvSeriesLoading();
      final result = await _getTvSeries.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield RecommendationTvSeriesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield RecommendationTvSeriesNoData('Empty Data');
          } else {
            yield RecommendationTvSeriesHasData(data);
          }
        },
      );
    }
  }
}
