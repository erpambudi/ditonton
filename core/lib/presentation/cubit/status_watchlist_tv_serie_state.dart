part of 'status_watchlist_tv_serie_cubit.dart';

abstract class StatusWatchlistTvSerieState extends Equatable {
  const StatusWatchlistTvSerieState();

  @override
  List<Object> get props => [];
}

class StatusWatchlistTvSerieInitial extends StatusWatchlistTvSerieState {}

class StatusWatchlistTvSerieLoading extends StatusWatchlistTvSerieState {}

class StatusWatchlistTvSerieLoaded extends StatusWatchlistTvSerieState {
  final bool status;

  StatusWatchlistTvSerieLoaded({required this.status});

  @override
  List<Object> get props => [status];
}

class StatusWatchlistTvSerieError extends StatusWatchlistTvSerieState {}
