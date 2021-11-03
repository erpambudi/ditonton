part of 'top_tv_series_bloc.dart';

abstract class TopTvSeriesState extends Equatable {
  const TopTvSeriesState();

  @override
  List<Object> get props => [];
}

class TopTvSeriesEmpty extends TopTvSeriesState {}

class TopTvSeriesLoading extends TopTvSeriesState {}

class TopTvSeriesError extends TopTvSeriesState {
  final String message;

  TopTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopTvSeriesNoData extends TopTvSeriesState {
  final String message;

  TopTvSeriesNoData(this.message);

  @override
  List<Object> get props => [message];
}

class TopTvSeriesHasData extends TopTvSeriesState {
  final List<TvSeries> result;

  TopTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
