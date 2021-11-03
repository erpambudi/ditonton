part of 'now_playing_tv_series_bloc.dart';

abstract class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvSeriesEmpty extends NowPlayingTvSeriesState {}

class NowPlayingTvSeriesLoading extends NowPlayingTvSeriesState {}

class NowPlayingTvSeriesError extends NowPlayingTvSeriesState {
  final String message;

  NowPlayingTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvSeriesNoData extends NowPlayingTvSeriesState {
  final String message;

  NowPlayingTvSeriesNoData(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvSeriesHasData extends NowPlayingTvSeriesState {
  final List<TvSeries> result;

  NowPlayingTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
